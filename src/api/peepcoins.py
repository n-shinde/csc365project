from sqlalchemy import text
from fastapi import APIRouter, Depends, HTTPException
from pydantic import BaseModel
from src.api import auth
from src import database as db

router = APIRouter(
    prefix="/peepcoins",
    tags=["peepcoins"],
    dependencies=[Depends(auth.get_api_key)],
)


class PeepCoinRequest(BaseModel):
    user_id: int
    change: int


add_peepcoins_query = text(
    """
    INSERT INTO user_peepcoin_ledger (user_id, change)
    VALUES (:user_id, :change)
    """
)


@router.put("/add")
def put_add_peepcoins(request: PeepCoinRequest):
    with db.engine.begin() as connection:
        connection.execute(
            add_peepcoins_query, {"user_id": request.user_id, "change": request.change}
        )
    return "OK"


class CouponRequest(BaseModel):
    coupon_id: int
    user_id: int


@router.post("/purchase/coupon")
def post_buy_coupon(request: CouponRequest):
    coupon_id = request.coupon_id
    user_id = request.user_id
    with db.engine.begin() as connection:
        # checking if the coupon is valid
        query = text("SELECT valid FROM coupons WHERE id = :coupon_id")
        is_valid = connection.execute(
            query, {"coupon_id": request.coupon_id}
        ).scalar_one()
        print(is_valid)
        if is_valid == "FALSE":
            return "coupon not valid"

        # checking if user can affording the transaction
        query = text(
            """
            SELECT (SELECT SUM(change) FROM user_peepcoin_ledger WHERE user_id = :user_id) >= price
                FROM coupons WHERE id = :coupon_id
            """
        )
        can_afford = connection.execute(
            query, {"user_id": user_id, "coupon_id": coupon_id}
        ).scalar_one()
        if not can_afford:
            return "user can't afford coupon"

        # removing peepcoins from their account
        query = text(
            "INSERT INTO user_peepcoin_ledger (user_id, change) VALUES (:user_id, -1 * (SELECT price FROM coupons where id = :coupon_id))"
        )
        connection.execute(query, {"user_id": user_id, "coupon_id": coupon_id})

        # adding coupon to their account
        query = text(
            "INSERT INTO user_coupon_ledger (user_id, coupon_id, change) VALUES (:user_id, :coupon_id, 1)"
        )
        connection.execute(query, {"user_id": user_id, "coupon_id": coupon_id})
        return "OK"
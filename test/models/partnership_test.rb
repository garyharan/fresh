require "test_helper"

class PartnershipTest < ActiveSupport::TestCase
 setup do
    @gathino = profiles(:one)
    @velvet = profiles(:two)
    @mariet = profiles(:three)
  end

  test "should validate uniqueness of from_profile_id scoped to to_profile_id" do
    Partnership.create!(from_profile: @gathino, to_profile: @velvet, status: :unconfirmed)
    duplicate = Partnership.new(from_profile: @gathino, to_profile: @velvet)

    assert_not duplicate.valid?
    assert_includes duplicate.errors[:from_profile_id], "has already been taken"
  end

  test "should confirm status if reciprocal partnership exists" do
    Partnership.create!(from_profile: @gathino, to_profile: @velvet, status: :unconfirmed)
    reciprocal = Partnership.create!(from_profile: @velvet, to_profile: @gathino, status: :unconfirmed)

    assert_equal "confirmed", reciprocal.reload.status
    assert_equal "confirmed", Partnership.find_by(from_profile: @gathino, to_profile: @velvet).status
  end

  test "should downgrade reciprocal partnership on destroy" do
    partnership = Partnership.create!(from_profile: @gathino, to_profile: @velvet, status: :confirmed)
    reciprocal = Partnership.create!(from_profile: @velvet, to_profile: @gathino, status: :confirmed)

    partnership.destroy

    assert_equal "unconfirmed", reciprocal.reload.status
  end

  test "reciprocal method should find the reciprocal partnership" do
    partnership = Partnership.create!(from_profile: @gathino, to_profile: @velvet, status: :unconfirmed)
    reciprocal = Partnership.create!(from_profile: @velvet, to_profile: @gathino, status: :confirmed)

    assert_equal reciprocal, partnership.reciprocal
  end
end

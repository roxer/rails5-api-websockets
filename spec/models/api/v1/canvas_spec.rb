require 'rails_helper'

RSpec.describe Api::V1::Canvas, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:api_v1_canvas)).to be_valid
  end

  context 'validations' do
    subject { FactoryGirl.build(:api_v1_canvas) }

    it do
      should validate_uniqueness_of(:name)
        .scoped_to(:diagram_id)
        .with_message('has already been taken')
        .case_insensitive
    end
  end
end

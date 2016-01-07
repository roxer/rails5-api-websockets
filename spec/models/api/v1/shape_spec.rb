require 'rails_helper'

RSpec.describe Api::V1::Shape, :type => :model do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:api_v1_shape)).to be_valid
  end

  context 'validations' do
    subject { FactoryGirl.build(:api_v1_shape) }

    it do
      should validate_uniqueness_of(:label)
        .with_message('has already been taken')
        .scoped_to(:canvas_id)
        .case_insensitive
    end
  end
end

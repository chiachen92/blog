require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "validations of the app" do
    it "must have a title" do
      p = Post.new({title: nil, body: "good body"})
      p.valid?
      expect(p.errors).to have_key(:title)
      # expect p to have errors and it does so the test pasts
    end

    it "must have at least 7 char in title" do
      p2 = Post.new({title: 123456, body: "good body"})
      p2.valid?
      expect(p2.errors).to have_key(:title)
      # expect p2 to have errors and it did because the title didn't have 7 characters so the test wil pass because it's what we expected
    end

    it "must have a body" do
      p = Post.new({title: "asdofhaewf", body: nil})
      p.valid?
      expect(p.errors).to have_key(:body)
      # expect p to have errors and it does so the test pasts
    end
  end

  describe "the body_snippet method" do
    it "must return a max of 100 char of the body" do
      p = Post.new({title: "asdofhaewf", body: "sdfasdfsadfasfasdfasfasdfasdfasdfasfdasdfsadfsadfsadfasdfsadfasdfsadfsadfsdfasdfasdfasdfsdfasdfsadfasfasdfasfasdfasdfasdfasfdasdfsadfsadfsadfasdfsadfasdfsadfsadfsdfasdfasdfasdfsdfasdfsadfasfasdfasfasdfasdfasdfasfdasdfsadfsadfsadfasdfsadfasdfsadfsadfsdfasdfasdfasdfsdfasdfsadfasfasdfasfasdfasdfasdfasfdasdfsadfsadfsadfasdfsadfasdfsadfsadfsdfasdfasdfasdf"})
      result = p.body_snippet
      expect(result.length).to be <=100
    end
  end

end

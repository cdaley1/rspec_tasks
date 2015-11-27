require 'spec_helper'
require 'httparty'

describe "Test Suite sends a post request" do 
	it "should create a new post in the collection" do
		r = HTTParty.post "http://lacedeamon.spartaglobal.com/todos", query: {title: "do something mad", due: "2017-02-01"}
		expect(r["title"] =~ /do something mad/)
		expect(r.code).to eq (201)

		r = HTTParty.delete "http://lacedeamon.spartaglobal.com/todos/#{r["id"]}"
		puts "Teardown successful"
	end

	it "should fail to make a post without correct parameters" do
		r = HTTParty.post "http://lacedeamon.spartaglobal.com/todos"
		expect(r.code).to eq 422
	end
end

describe "Test Suite sends a get request" do 
	it "should retrieve a post in the collection" do

	end
end

describe "Test Suite sends a put request" do 
	it "should completely apdate post in the collection" do

	end
end

describe "Test Suite sends a patch request" do 
	it "should partially update post in the collection" do

	end
end
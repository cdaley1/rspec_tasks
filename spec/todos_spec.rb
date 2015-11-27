require 'spec_helper'
require 'httparty'

describe "Test Suite sends a post request" do 
	it "should create a new post in the collection" do
		rpost = HTTParty.post "http://lacedeamon.spartaglobal.com/todos", query: {title: "do something mad", due: "2017-02-01"}
		expect(rpost["title"] == "do something mad")
		expect(rpost.code).to eq 201

		r = HTTParty.delete "http://lacedeamon.spartaglobal.com/todos/#{rpost["id"]}"
		puts "Teardown successful"
	end

	it "should fail to make a post without correct parameters" do
		r = HTTParty.post "http://lacedeamon.spartaglobal.com/todos"
		expect(r.code).to eq 422
	end

end

describe "Test Suite sends a get request" do 
	it "should create & retrieve an item in the collection using it's specific id" do
		rpost = HTTParty.post "http://lacedeamon.spartaglobal.com/todos", query: {title: "do something mad", due: "2017-02-01"}
		rget = HTTParty.get "http://lacedeamon.spartaglobal.com/todos/#{rpost["id"]}"
		expect(rget.code).to eq 200
		puts(rget.content_type)

		rdel = HTTParty.delete "http://lacedeamon.spartaglobal.com/todos/#{rget["id"]}"
		puts "Teardown successful"
	end

	it "should not retrieve an item in the collection if it doesn't exist" do
		rpost = HTTParty.post "http://lacedeamon.spartaglobal.com/todos", query: {title: "do something mad", due: "2017-02-01"}
		rget = HTTParty.get "http://lacedeamon.spartaglobal.com/todos/222222"
		expect(rget.code).to eq 404
		puts(rpost.message)

		rdel = HTTParty.delete "http://lacedeamon.spartaglobal.com/todos/#{rpost["id"]}"
		puts "Teardown successful"
	end

	it "should retrieve the todos collection" do
		rget = HTTParty.get "http://lacedeamon.spartaglobal.com/todos"
		expect(rget.message == "OK")
	end

end

describe "Test Suite sends a put request" do 
	it "should create & completely update an item in the collection" do
		rpost = HTTParty.post "http://lacedeamon.spartaglobal.com/todos", query: {title: "do something mad", due: "2017-02-01"}
		rput = HTTParty.put "http://lacedeamon.spartaglobal.com/todos/#{rpost["id"]}", query: {title: "do something mad again", due: "2017-03-01"}
		expect(rput.code).to eq 200
		expect(rput["title"] != rpost["title"])
		expect(rput["due"] != rpost["due"])

		rdel = HTTParty.delete "http://lacedeamon.spartaglobal.com/todos/#{rput["id"]}"
	end

end

describe "Test Suite sends a patch request" do 
	it "should partially update an item in the collection" do
		rpost = HTTParty.post "http://lacedeamon.spartaglobal.com/todos", query: {title: "do something mad", due: "2017-02-01"}
		rpatch = HTTParty.patch "http://lacedeamon.spartaglobal.com/todos/#{rpost["id"]}", query: {title: "do something mad again"}
		expect(rpatch.code).to eq 200
		expect(rpatch["title"] != rpost["title"])

		rdel = HTTParty.delete "http://lacedeamon.spartaglobal.com/todos/#{rpatch["id"]}"

	end

end
describe "Test suite should send delete request" do
	it "should delete an item in the todos collection" do
		rpost = HTTParty.post "http://lacedeamon.spartaglobal.com/todos", query: {title: "do something mad", due: "2017-02-01"}
		rdel = HTTParty.delete "http://lacedeamon.spartaglobal.com/todos/#{rpost["id"]}"
		expect(rdel.code).to eq 204
	end

	it "should not delete the collection" do
		rdel = HTTParty.delete "http://lacedeamon.spartaglobal.com/todos"
		#expect(rdel)to. eq 
	end

end



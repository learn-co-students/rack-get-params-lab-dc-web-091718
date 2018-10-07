class Application

  @@items = ["Apples","Carrots","Pears"]
  #create a new class array called @@cart
  #to hold any item in your cart
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
  #create a new route called /cart
  #to show the items in your cart
    elsif req.path.match(/cart/)
  #if the cart is not empty
      if !@@cart.empty?
  #write out each item in the cart
        @@cart.each {|item| resp.write "#{item}\n"}
      else
  #if cart is empty, output "Your cart is empty"
        resp.write "Your cart is empty."
      end
  #create a new route called /add that takes in a GET param
  #with the key item
    elsif req.path.match(/add/)
      add_item = req.params["item"]
  #this should check to see if that item is in @@items
      if !@@items.include? add_item
        resp.write "We don't have that item"
      else
    #and then add it to the cart if it is. Otherwise error
        @@cart << add_item
        resp.write "added #{add_item}"
      end
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end

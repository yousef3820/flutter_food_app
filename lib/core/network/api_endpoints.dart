class ApiEndpoints {
  static const baseUrl = "https://sonic-zdi0.onrender.com/api/"; 
  //Authuntication 
  static const register = "register";
  static const login = "login";
  static const profile = "profile";
  static const updateProfile= "update-profile";
  static const logout = "logout";

  //products

  static const products = "products";

  //toppings
  static const toppings = "toppings";

  static const sideOptions = "side-options";

  //orders

  static const addTocart = "cart/add";

  static const getCart = "cart";

  static const deleteFromCart = "cart/remove";

  //favorites

  static const toggleFavorite= "toggle-favorite";

    static const getUserFavorites = "favorites";

}

class ApiKeys{
  //authuntication
  static const code  = "code";
  static const message = "message";
  static const data = "data";
  static const token = "token";
  static const name = "name";
  static const email = "email";
  static const image = "image";
  static const phone = "phone";
  static const password = "password";
  static const address = "address";
  static const visa = "visa";

  //products

  static const id = "id";
  static const productName = "name";
  static const description = "description";
  static const productImage = "image";
  static const rating = "rating";
  static const price = "price";

  //toppings

  static const toppingsId = "id";
  static const toppingsName = "name";
  static const toppingsImage = "image";

  //cart

  //add
  static const productOrderId = "product_id";

  static const productOrderQuantity = "quantity";

  static const productOrderSpicy = "spicy";

  static const productOrderToppings = "toppings";

  static const productOrderSideoptions = "side_options";

  //get

  static const cartOrderItems = "items";
  static const cartOrderId = "id";

  static const totalPrice = "total_price";

  static const cartItemId = "item_id";

  //favorites

  static const favoriteProductId = "product_id";

}
import Map "mo:core/Map";
import List "mo:core/List";
import Text "mo:core/Text";

module {
  type BookFormat = {
    #kindle : Text;
    #paperback : Text;
  };

  type Book = {
    id : Text;
    title : Text;
    description : Text;
    genre : Text;
    coverImageUrl : Text;
    formats : [BookFormat];
    audiobookLink : ?Text;
    featured : Bool;
  };

  type BlogPost = {
    id : Text;
    title : Text;
    category : Text;
    content : Text;
    excerpt : Text;
    coverImageUrl : Text;
    publishedAt : Int;
  };

  type Review = {
    bookId : Text;
    reviewerName : Text;
    email : Text;
    rating : Nat;
    comment : Text;
  };

  type OrderItem = {
    productId : Text;
    name : Text;
    quantity : Nat;
    price : Nat;
    currency : Text;
  };

  type Order = {
    id : Text;
    customerName : Text;
    customerEmail : Text;
    customerPhone : Text;
    items : [OrderItem];
    totalAmount : Nat;
    currency : Text;
    status : Text;
    createdAt : Int;
    razorpayPaymentId : Text;
    notes : Text;
  };

  type Coupon = {
    code : Text;
    discountType : Text;
    discountValue : Nat;
    maxUsages : Nat;
    usageCount : Nat;
    expiryDate : Int;
    isActive : Bool;
    currency : Text;
  };

  type Audiobook = {
    id : Text;
    name : Text;
    description : Text;
    priceINR : Nat;
    priceUSD : Nat;
    duration : Text;
    narrator : Text;
    coverEmoji : Text;
    razorpayUrlINR : Text;
    razorpayUrlUSD : Text;
    isActive : Bool;
  };

  type MerchItem = {
    id : Text;
    name : Text;
    description : Text;
    priceINR : Nat;
    priceUSD : Nat;
    category : Text;
    coverEmoji : Text;
    razorpayUrl : Text;
    isActive : Bool;
  };

  type Setting = {
    key : Text;
    value : Text;
  };

  type OldActor = {
    books : Map.Map<Text, Book>;
    blogPosts : Map.Map<Text, BlogPost>;
    reviews : Map.Map<Text, List.List<Review>>;
    subscribers : List.List<Text>;
    authorBio : Text;
    orders : Map.Map<Text, Order>;
    coupons : Map.Map<Text, Coupon>;
    audiobooks : Map.Map<Text, Audiobook>;
    merchItems : Map.Map<Text, MerchItem>;
    settings : Map.Map<Text, Setting>;
  };

  // New types
  type CustomerAccount = {
    id : Text;
    name : Text;
    email : Text;
    passwordHash : Text;
    createdAt : Int;
  };

  type NewOrder = {
    id : Text;
    customerId : ?Text;
    customerName : Text;
    customerEmail : Text;
    customerPhone : Text;
    shippingAddress : ?ShippingAddress;
    items : [OrderItem];
    totalAmount : Nat;
    currency : Text;
    status : Text;
    createdAt : Int;
    razorpayPaymentId : Text;
    notes : Text;
  };

  type CustomerAddress = {
    id : Text;
    customerId : Text;
    addressLabel : Text;
    fullName : Text;
    phone : Text;
    line1 : Text;
    line2 : Text;
    city : Text;
    state : Text;
    pincode : Text;
    country : Text;
    isDefault : Bool;
  };

  type ShippingAddress = {
    fullName : Text;
    phone : Text;
    line1 : Text;
    line2 : Text;
    city : Text;
    state : Text;
    pincode : Text;
    country : Text;
  };

  type NewActor = {
    books : Map.Map<Text, Book>;
    blogPosts : Map.Map<Text, BlogPost>;
    reviews : Map.Map<Text, List.List<Review>>;
    subscribers : List.List<Text>;
    authorBio : Text;
    orders : Map.Map<Text, NewOrder>;
    coupons : Map.Map<Text, Coupon>;
    audiobooks : Map.Map<Text, Audiobook>;
    merchItems : Map.Map<Text, MerchItem>;
    settings : Map.Map<Text, Setting>;
    customerAccounts : Map.Map<Text, CustomerAccount>;
    customerAddresses : Map.Map<Text, CustomerAddress>;
  };

  public func run(old : OldActor) : NewActor {
    let newOrders = old.orders.map<Text, Order, NewOrder>(
      func(_id, oldOrder) {
        {
          oldOrder with shippingAddress = null; customerId = null;
        };
      }
    );

    {
      old with
      orders = newOrders;
      customerAccounts = Map.empty<Text, CustomerAccount>();
      customerAddresses = Map.empty<Text, CustomerAddress>();
    };
  };
};

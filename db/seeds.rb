ian = User.create(name: "Ian", username: "ianoka", password: "password")
kelly = User.create(name: "Kelly", username: "larocachica", password: "password")

RestaurantEntry.create(user_id: ian.id, name: "Jacob's Pickles", content: "Yumm! This place is great!", dish: "croque madame", drink: "lemonade", service: "phenomenal", price: "moderate", atmosphere: "lively and low-key")
RestaurantEntry.create(user_id: ian.id, name: "Jacob's Pickles", content: "You get so much food at this place!", dish: "chicken waffle", drink: "vanilla rootbeer", service: "good", price: "moderate", atmosphere: "loud music but fun")

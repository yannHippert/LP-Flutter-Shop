import 'package:uuid/uuid.dart';

const uuid = Uuid();

final gloves = [
  {
    "id": uuid.v4(),
    "name": "Christmas Jumper in 3D Look",
    "url":
        "https://www.amazon.de/-/en/ASVP-Shop%C2%AE-Unisex-Christmas-Jumper/dp/B016F5445A/ref=sr_1_5?keywords=h%C3%A4ssliche+weihnachtspullover&qid=1678187142&sr=8-5",
    "variants": [
      {
        "id": uuid.v4(),
        "size": {"name": "S"},
        "price": 14.99
      },
      {
        "id": uuid.v4(),
        "size": {"name": "M"},
        "price": 16.99
      },
      {
        "id": uuid.v4(),
        "size": {"name": "L"},
        "price": 19.99
      }
    ],
    "description":
        "The most popular Christmas jumper for this Christmas party - an absolute must for any Christmas partyChristmas jumper in a 3D look with real Christmas baubles made of plush fabric to touch - the ideal icebreaker for all Christmas parties this winter.Langarm100 % Acrylic FibreWeihnachtspulloverOur 3D Christmas jumper is not only cool and fun but will also keep you warm through the cold Christmas season.Made from 100% high-quality acrylic for a comfortable feel - the ideal Christmas jumper for men and women - available in 6 sizes.Impress your friends, family and colleagues this Christmas with this fantastic Christmas pullover - the absolute must for your wardrobe.",
    "image": "https://m.media-amazon.com/images/I/61MsTLVQlKL._AC_UL1000_.jpg",
    "category": "sweater"
  },
];

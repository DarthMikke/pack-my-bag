//
//  mockLists.swift
//  Pack my Bag
//
//  Created by Michal Jan Warecki on 06/10/2021.
//

import Foundation

let lists: Dictionary<String, Array<MockPackingList>> = [
    "en": [
        MockPackingList(
            name: "Moving",
            containers: [
                MockContainer(
                    name: "Kitchen",
                    items: [
                        MockItem(name: "KitchenAid"),
                        MockItem(name: "Plates"),
                        MockItem(name: "Pans"),
                        MockItem(name: "Silverware from Grandma"),
                    ]
                ),
                MockContainer(
                    name: "Bathroom",
                    items: [
                        MockItem(name: "Toothbrush"),
                        MockItem(name: "Tooth paste"),
                        MockItem(name: "Towel"),
                        MockItem(name: "Soap dish"),
                        MockItem(name: "Detergents"),
                    ]
                ),
                MockContainer(
                    name: "Living room",
                    items: [
                        MockItem(name: "Vase"),
                        MockItem(name: "Coasters"),
                        MockItem(name: "Table cloths"),
                    ]
                ),
                MockContainer(
                    name: "Bedroom",
                    items: [
                        MockItem(name: "Duvet"),
                        MockItem(name: "Pillows"),
                        MockItem(name: "Linens"),
                        MockItem(name: "Mattress protector"),
                    ]
                )
            ]
        ),
        MockPackingList(
            name: "Cabin trip",
            containers: [
                MockContainer(
                    name: "Big bag",
                    items: [
                        MockItem(name: "Kvikklunsj!"),
                        MockItem(name: "Skiing clothes"),
                        MockItem(name: "Woolen sweather"),
                        MockItem(name: "Underwear"),
                    ]
                ),
                MockContainer(
                    name: "Ski cover",
                    items: [
                        MockItem(name: "Ski"),
                        MockItem(name: "Sticks"),
                        MockItem(name: "Shoes"),
                        MockItem(name: "Ski wax"),
                    ]
                ),
                MockContainer(
                    name: "Food",
                    items: [
                        MockItem(name: "Mince meat"),
                        MockItem(name: "Spaghetti"),
                        MockItem(name: "Hunter's stew"),
                        MockItem(name: "Tacos"),
                        MockItem(name: "Greens and veggies"),
                        MockItem(name: "Corn"),
                        MockItem(name: "Drink"),
                    ]
                ),
            ]
        )
    ],
    "nn": [
        MockPackingList(
            name: "Flytting",
            containers: [
                MockContainer(
                    name: "Kjøken",
                    items: [
                        MockItem(name: "KitchenAid"),
                        MockItem(name: "Fat og tallerkar"),
                        MockItem(name: "Steikepanner"),
                        MockItem(name: "Sølvbestikk frå mormor"),
                    ]
                ),
                MockContainer(
                    name: "Bad",
                    items: [
                        MockItem(name: "Tannkost"),
                        MockItem(name: "Tannkrem"),
                        MockItem(name: "Tanntråd"),
                        MockItem(name: "Handdukar"),
                        MockItem(name: "Såpeskål"),
                        MockItem(name: "Vaskemiddel"),
                    ]
                ),
                MockContainer(
                    name: "Stove",
                    items: [
                        MockItem(name: "Vase"),
                        MockItem(name: "Bordbrikkar"),
                        MockItem(name: "Dukar"),
                    ]
                ),
                MockContainer(
                    name: "Soverom",
                    items: [
                        MockItem(name: "Dyner"),
                        MockItem(name: "Putar"),
                        MockItem(name: "Sengetøy"),
                        MockItem(name: "Madrassbeskyttar"),
                    ]
                )
            ]
        ),
        MockPackingList(
            name: "Hyttetur",
            containers: [
                MockContainer(
                    name: "Stor sekk",
                    items: [
                        MockItem(name: "Ullundertøy"),
                        MockItem(name: "Ullgenser"),
                        MockItem(name: "Kvikklunsj!"),
                        MockItem(name: "Skiklede"),
                    ]
                ),
                MockContainer(
                    name: "Skipose",
                    items: [
                        MockItem(name: "Ski"),
                        MockItem(name: "Stavar"),
                        MockItem(name: "Sko"),
                        MockItem(name: "Smøring"),
                    ]
                ),
                MockContainer(
                    name: "Mat",
                    items: [
                        MockItem(name: "Kjøtdeig"),
                        MockItem(name: "Spaghetti"),
                        MockItem(name: "Jegargryte (pose)"),
                        MockItem(name: "Tacokrydder"),
                        MockItem(name: "Grønsaker"),
                        MockItem(name: "Maisboksar"),
                        MockItem(name: "Drikke"),
                    ]
                ),
            ]
        )
    ]
]

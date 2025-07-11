// ##### automatic securities dealer names! -- Michael Scott Cuthbert for Lisa Friedland ca. 2007
// #include <stdmap.pbi>
// #include <format.pbi>

main: company company company company
      company company company company
      company company company company
      company company company company
      company company company company
      company company company company
      company company company company
      company company company company
      company company company company
      company company company company;

company: front back "\n";

front: article front_type;

article: "The " | "" | "" | "" | "" | "";

front_type:
     initial_type |
     animal_type " "|
     flower_type " " |
     people_adjective " " |
     legal_term " " |
     culinary_term " " |
     front_type "& " front_type;

back: back_adjective back_noun back_gibberish;


// ## hard to tell their adjectives from their nouns

back_adjective: "" | "" | "" |"" | "" | "" |
        "Investment " |
        insurance | insurance |
        "International "|
        securities | securities |
        "Financial " |
        service |
        "Perpetual " | "Diversified " | "Options " | "Management " |
        "Asset " |
        "Trading " | "Investors " | "First " | "Commercial " |
        back_adjective back_adjective ;

back_noun:
    advisors |
    "Agency " | "Group " | "Corporation " |
    "Planning " | bankthing | brokers | "Capital " | "Counsel " |
    "Distributors " | "Enterprises " |
    securities | securities |
    service |
    "Specialists " | "International " |
    corp | corp |
    "Advantage " |
    equity | "Consultants " |
    "Partners " |
    limited-maybe "Partnership " |
    back_noun "of " location |
    back_noun back_noun |
    back_noun and_thing "Associates ";

limited-maybe: "" | "Limited ";
insurance: "Insurance " | "Insurance " | "Life Insurance " | "Pension Insurance ";
securities: "Securities " | "Securities " | "Transfer Securities ";
service: "Service " | "Services ";
equity: "Equity " | "Equities ";
bankthing: "Banking " | "Bankers ";
brokers: "Brokerage " | "Brokers " | "Broker " | "Brokerage " | "Broker/Dealer ";
corp: corp2 | and_thing corp2;
corp2: "Co. " | "Company " | "Co. " | "Company " | "Corp " | "Corp. " | "Corporation ";
back_gibberish: "" | "" | "L.L.C." | "Inc." | "Inc." | "LLC" |
                "LTD." | "Incorporated";
and_thing: "& " | "and ";

location: "America " | "America " | "California " | "New York " |
          "Florida ";

advisors: "Advisors " | "Advisors " | "Advisers " | "Advisory ";

initial_type: initial ". " | initial ". " | initial ".-" initial ". " |
              initial " & " initial " " | initial_type initial " ";

initial: "A" | "B" | "C" | "D" | "E" | "F" | "G" | "H" | "I" | "J" |
         "K" | "L" | "M" | "N" | "O" | "P" | "Q" | "R" | "S" | "T" |
         "U" | "V" | "W" | "X" | "Y" | "Z";


// to make:
// cat culinary_terms.txt | perl -pe 's/\s+$//; s/\b(\w)/uc($1)/ge; $_= "\"" . $_ . "\" | \n";' > ! flowers2.txt

animal_type:
"Aardvark" |
"Aardwolf" |
"Addax" |
"Addra" |
"African Elephant" |
"African Lion" |
"African Wild Cat" |
"African Wild Dog" |
"Agile Antechinus" |
"Agile Wallaby" |
"Agouti" |
"Agrant Shrew" |
"Alaska Vole" |
"Allied Rock-Wallaby" |
"Alpaca" |
"American Badger" |
"American Bison" |
"American Mink" |
"American Porcupine" |
"Ampurta" |
"Amur Tiger" |
"Anteater" |
"Antelope" |
"Ape" |
"Arctic Fox" |
"Arctic Ground Squirrel" |
"Arctic Hare" |
"Arctic Wolf" |
"Armadillo" |
"Arnoux's Beaked Whale" |
"Arsinoitherium" |
"Artiodactyls" |
"Asian Elephant" |
"Asian Lion" |
"Asiatic Black Bear" |
"Atherton Antechinus" |
"Aye-Aye" |
"Babirusa" |
"Baboon" |
"Bactrian Camel" |
"Badger" |
"Bahamonde's Beaked Whale" |
"Baiji" |
"Baleen Whale" |
"Banded Duiker" |
"Banded Hare-Wallaby" |
"Banded Mongoose" |
"Bandicoot" |
"Bat" |
"Bay Duiker" |
"Bearded seal" |
"Beaver" |
"Beluga Whale" |
"Bengal Tiger" |
"Bennett's Tree-Kangaroo" |
"Big Brown Bat" |
"Bighorn Sheep" |
"Bilby" |
"Binturong" |
"Bison" |
"Black Bear" |
"Black Lemur" |
"Black Rat" |
"Black Tailed Jack Rabbit" |
"Black Wallaroo" |
"Blackbuck" |
"Black-Footed Ferret" |
"Black-Striped Wallaby" |
"Black-Tailed Jack Rabbit" |
"Blue Whale" |
"Bobcat" |
"Bongo" |
"Boto" |
"Bottle-Nosed Dolphin" |
"Bowhead Whale" |
"Brazilian Free-Tailed Bat" |
"Bridled Nailtail Wallaby" |
"Broad Faced Potoroo" |
"Brown Antechinus" |
"Brown Bear" |
"Brown Rat" |
"Brush-Tailed Bettong" |
"Brush-Tailed Phascogale" |
"Bryde's Whale" |
"Buffalo" |
"Burmeister's Porpoise" |
"Burmese Cat" |
"Burrowing Bettong" |
"Bush Dog" |
"Bush Pig" |
"Bushy-Tailed Woodrat" |
"Butler's Dunnart" |
"California Myotis" |
"California Sea Lion" |
"Camel" |
"Canyon Mouse" |
"Cape Buffalo" |
"Cape Hunting Dog" |
"Cape York Rock Wallaby" |
"Capuchin" |
"Capybara" |
"Caracal" |
"Caribou" |
"Carpentarian Pseudantechinus" |
"Cat" |
"Chamois" |
"Cheetah" |
"Chestnut Dunnart" |
"Chevrotain" |
"Chilean Dolphin" |
"Chimpanzee" |
"Chinchilla" |
"Chipmunk" |
"Cinnamon Antechinus" |
"Civet" |
"Cliff Chipmunk" |
"Clouded Leopard" |
"Clymene Dolphin" |
"Coati" |
"Collared Lemming" |
"Collared Peccary" |
"Commerson's Dolphin" |
"Common Brushtail Possum" |
"Common Duiker" |
"Common Dunnart" |
"Common Planigale" |
"Common Ringtail Possum" |
"Common Spotted Cuscus" |
"Common Wallaroo" |
"Common Wombat" |
"Cougar" |
"Cow" |
"Coyote" |
"Coypu" |
"Crabeater Seal" |
"Cuvier's Beaked Whale" |
"Dall Sheep" |
"Dark Kangaroo Mouse" |
"Deer" |
"Deer Mouse" |
"Dense-Beaked Whale" |
"Desert Cottontail" |
"Desert Rat-Kangaroo" |
"Desert Woodrat" |
"Dhole" |
"Dingo" |
"Dog" |
"Dolphin" |
"Donkey" |
"Dromedary Camel" |
"Duck-Billed Platypus" |
"Dugong" |
"Dusky Antechinus" |
"Dusky Dolphin" |
"Eastern Barred Bandicoot" |
"Eastern Chipmunk" |
"Eastern Cougar" |
"Eastern Grey Kangaroo" |
"Eastern Grey Squirrel" |
"Eastern Mole" |
"Eastern Pipistrelle" |
"Eastern Pygmy Possum" |
"Eastern Quoll" |
"Eastern Small-Footed Bat" |
"Eastern Tarsier" |
"Echidna" |
"Egyptian Mongoose" |
"Ekaltadeta" |
"Eland" |
"Elephant" |
"Elephant seal" |
"Elk" |
"Ermine" |
"Eurasian Otter" |
"European Hare" |
"European Hedgehog" |
"European Mole" |
"European Rabbot" |
"Evening Bat" |
"Fallow Deer" |
"False Killer Whale" |
"Fanaloka" |
"Fat-Tailed Dunnart" |
"Fat-Tailed Pseudantechinus" |
"Fawn Antechinus" |
"Feathertail Glider" |
"Fennec Fox" |
"Feral Pig" |
"Ferret" |
"Fin Whale" |
"Finless Porpoise" |
"Fisher" |
"Florida Manatee" |
"Florida Mastiff Bat" |
"Flying Squirrel" |
"Fossa" |
"Fox" |
"Franciscana" |
"Fraser's Dolphin" |
"Free-Tailed Bat" |
"Fruit Bat" |
"Ganges River Dolphin" |
"Gaur" |
"Gazelle" |
"Gemsbok" |
"Genet" |
"Gerbil" |
"Gerenuk" |
"Gervais' Beaked Whale" |
"Giant Anteater" |
"Giant Armadillo" |
"Giant Otter" |
"Giant Panda" |
"Gibbon" |
"Gilbert's Dunnart" |
"Giles' Planigale" |
"Ginkgo-Toothed Beaked Whale" |
"Giraffe" |
"Gnu" |
"Goat" |
"Godman's Rock Wallaby" |
"Golden Bandicoot" |
"Golden Lion Tamarin" |
"Goose-Beaked Whale" |
"Gopher" |
"Goral" |
"Gorilla" |
"Grant's Gazelle" |
"Gray Fox" |
"Gray Seal" |
"Gray Whale" |
"Gray's Beaked Whale" |
"Great Basin Kangaroo Rat" |
"Great Basin Pocket Mouse" |
"Greater Glider" |
"Green Ringtail Possum" |
"Grey Bellied Dunnart" |
"Grey Whale" |
"Grison" |
"Grizzly Bear" |
"Groundhog" |
"Guadalupe Fur Seal" |
"Guanaco" |
"Hairy Footed Dunnart" |
"Hairy-Tailed Mole" |
"Hamsters" |
"Harbor Porpoise" |
"Harbor Seal" |
"Hare" |
"Harp Seal" |
"Hartebeest" |
"Heaviside's Dolphin" |
"Hector's Beaked Whale" |
"Hector's Dolphin" |
"Hedgehog" |
"Herbert River Ringtail Possum" |
"Herbert's Rock Wallaby" |
"Hippopotamus" |
"Hoary Bat" |
"Hoary Marmot" |
"Hog Badger" |
"Honey Badger" |
"Honey Possum" |
"Hooded Seal" |
"Horse" |
"Hourglass Dolphin" |
"House Cat" |
"House Mouse" |
"Howler Monkey" |
"Hubbs' Beaked Whale" |
"Humpback Whale" |
"Hyena" |
"Ibex" |
"Impala" |
"Indian Rhinoceros" |
"Indiana Bat" |
"Indo-Pacific Humpbacked Dolphin" |
"Indus River Dolphin" |
"Irrawaddy Dolphin" |
"Jaguar" |
"Jaguarundi" |
"Javelina" |
"Julia Creek Dunnart" |
"Kakadu Dunnart" |
"Kangaroo" |
"Kangaroo Island Dunnart" |
"Kangaroo Rat" |
"Karakul" |
"Killer Whale" |
"Kinkajou" |
"Kirk's Dik-Dik" |
"Kit Fox" |
"Klipspringer" |
"Koala" |
"Kowari" |
"Kudu" |
"Kultarr" |
"Leadbeater's Possum" |
"Least Chipmunk" |
"Least Weasel" |
"Lechwe" |
"Lemming" |
"Lemur" |
"Lemuroid Ringtail Possum" |
"Leopard" |
"Lesser Hairy Footed Dunnart" |
"Linsang" |
"Lion" |
"Little Pocket Mouse" |
"Little Pygmy Possum" |
"Little-Long Tailed Dunnart" |
"Llama" |
"Long Footed Potoroo" |
"Long Nosed Potoroo" |
"Long-beaked Common Dolphin" |
"Long-eared Myotis" |
"Long-Finned Pilot Whale" |
"Longman's Beaked Whale" |
"Long-Tailed Dunnart" |
"Long-Tailed Planigale" |
"Long-Tailed Pocket Mouse" |
"Long-Tailed Pygmy Possum" |
"Long-Tailed Vole" |
"Long-Tailed Weasel" |
"Loris" |
"Lumholtz's Tree-kangaroo" |
"Lynx" |
"Manatee" |
"Maned Wolf" |
"Manul" |
"Markhor" |
"Marmot" |
"Marsupial Mole" |
"Marten" |
"Meadow Vole" |
"Mediterranean Monk" |
"Meerkat" |
"Melon-Headed Whale" |
"Merriam's Shrew" |
"Mink" |
"Minke Whale" |
"Mole" |
"Mongoose" |
"Monjon" |
"Monkey" |
"Montane Shrew" |
"Montane Vole" |
"Moose" |
"Mouflon" |
"Mountain Brushtail Possum" |
"Mountain Goat" |
"Mountain Gorilla" |
"Mountain Hare" |
"Mountain Lion" |
"Mountain Pygmy Possum" |
"Mouse" |
"Mouse Deer" |
"Mule" |
"Mule Deer" |
"Mulgara" |
"Musk Ox" |
"Muskrat" |
"Musky Rat-kangaroo" |
"Mustang" |
"Nabarlek" |
"Naked Mole-Rat" |
"Narbalek" |
"Narwhal" |
"New England Cottontail" |
"Nine Banded Armadillo" |
"Ningbing Pseudantechinus" |
"Norrow-Nosed Planigale" |
"North Atlantic Beaked Whale" |
"Norther Dibbler" |
"Northern Bettong" |
"Northern Black Right Whale" |
"Northern Brown Bandicoot" |
"Northern Elephant Seal" |
"Northern Flying Squirrel" |
"Northern Fur Seal" |
"Northern Grasshopper Mouse" |
"Northern Hairy-Nosed Wombat" |
"Northern Nailtail Wallaby" |
"Northern Quoll" |
"Northern Rightwhale Dolphin" |
"Northern Short-Tailed shrew" |
"Northern Yellow Bat" |
"Norway Rat" |
"Numbat" |
"Nutall Cottontail" |
"Nutria" |
"Ocelot" |
"Okapi" |
"Old World Badger" |
"Ooldea Dunnart" |
"Opossum" |
"Orangutan" |
"Orca" |
"Ord Kangaroo Rat" |
"Oribi" |
"Oryx" |
"Otter" |
"Pacific Water Shrew" |
"Pacific White-Sided Dolphin" |
"Pallid Bat" |
"Palm Civet" |
"Panda" |
"Pangolin" |
"Panther" |
"Pantropical Spotted Dolphin" |
"Paraguayan Fox" |
"Parma Wallaby" |
"Peale's Dolphin" |
"Peary Caribou" |
"Persian Cat" |
"Pig" |
"Pika" |
"Pilbara Ningaui" |
"Pine Marten" |
"Pinyon Mouse" |
"Platypus" |
"Polar Bear" |
"Polecat" |
"Porcupine" |
"Prairie Dog" |
"Preble's Shrew" |
"Pronghorn" |
"Pronghorn Antelope" |
"Proserpine Rock-Wallaby" |
"Przewalski's Horse" |
"Puma" |
"Pygmy Cottontail" |
"Pygmy Hippopotamus" |
"Pygmy Sperm Whale" |
"Quokka" |
"Quoll" |
"Rabbit" |
"Raccoon" |
"Raccoon-Dog" |
"Rat" |
"Red Bat" |
"Red Bellied Pademelon" |
"Red Fox" |
"Red Kangaroo" |
"Red Legged Pademelon" |
"Red Necked Pademelon" |
"Red Panda" |
"Red Squirrel" |
"Red Wolf" |
"Red-Cheeked Dunnart" |
"Red-Necked Wallaby" |
"Red-Tailed Phascogale" |
"Reedbuck" |
"Reindeer" |
"Rhinoceros" |
"Ribbon Seal" |
"Richardson Ground" |
"Right Whale" |
"Ringtail Cat" |
"Ringtail Possum" |
"Ring-Tailed Lemur" |
"Risso's Dolphin" |
"River Otter" |
"Rock Ringtail Possum" |
"Rock Squirrel" |
"Roe Deer" |
"Rough-Toothed Dolphin" |
"Royal Antelope" |
"Rufous Bettong" |
"Rufous Hare Wallaby" |
"Rufous Spiny Bandicoot" |
"Sable Antelope" |
"Saddle-Backed Dolphin" |
"Sagebrush Vole" |
"Saiga Antelope" |
"Salt's Dik-Dik" |
"Sandhill Dunnart" |
"Scaly-Tailed Possum" |
"Scrub Hare" |
"Sea Otter" |
"Seal" |
"Sei Whale" |
"Seminole Bat" |
"Serow" |
"Serval" |
"Sheep" |
"Shepherd's Beaked Whale" |
"Short Earned Rock Wallaby" |
"Short-Finned Pilot Whale" |
"Siamang" |
"Siberian Tiger" |
"Sika Deer" |
"Simian Jackal" |
"Siver-Naired Bat" |
"Skunk" |
"Sloth" |
"Sloth Bear" |
"Smoky Shrew" |
"Snow Leopard" |
"Snowshoe Hare" |
"Southeastern Bat" |
"Southern Bog Lemming" |
"Southern Brown Bandicoot" |
"Southern Common Cuscus" |
"Southern Dibbler" |
"Southern Flying Squirrel" |
"Southern Hairy-Nosed Wombat" |
"Southern Ningaui" |
"Southern Pocket Gopher" |
"Sowerby's Beaked Whale" |
"Spectacled Hare-Wallaby" |
"Spectacled Porpoise" |
"Sperm Whale" |
"Spider Monkey" |
"Spinner Dolphin" |
"Spotted Hyena" |
"Spotted Skunk" |
"Spotted-Tailed Quoll" |
"Springbok" |
"Squirrel" |
"Squirrel Glider" |
"Squirrel Monkey" |
"Star-Nosed Mole" |
"Steenbok" |
"Stejneger's Beaked Whale" |
"Steller Sea Lion" |
"Straptoothed Whale" |
"Striped Dolphin" |
"Striped Possum" |
"Striped Skunk" |
"Stripe-Faced Dunnart" |
"Sugar Glider" |
"Sun Bear" |
"Swamp Antechinus" |
"Swamp Wallaby" |
"Takin" |
"Tammar Wallaby" |
"Tapir" |
"Tarsier" |
"Tasmanian Bettong" |
"Tasmanian Devil" |
"Tasmanian Tiger" |
"Tetra" |
"Thomson's Gazelle" |
"Three-toed Sloth" |
"Thylacine" |
"Tiger" |
"Topi" |
"Townsend's Ground Squirrel" |
"Trowbridge's Shrew" |
"True's Beaked Whale" |
"Tucuxi" |
"Tundra Hare" |
"Tundra Red-Back Vole" |
"Twilight Bats" |
"Uinta Chipmunk" |
"Unadorned Rock Wallaby" |
"Vagrant Shrew" |
"Vampire Bat" |
"Vaquita" |
"Vicuna" |
"Virginia Opossum" |
"Wallaby" |
"Walrus" |
"Warthog" |
"Water Shrew" |
"Waterbuck" |
"Weasel" |
"Weddell Seal" |
"Wester Quoll" |
"Western Barred Bandicoot" |
"Western Brush Wallaby" |
"Western Grey Kangaroo" |
"Western Havest Mouse" |
"Western Jumping Mouse" |
"Western Pygmy Possum" |
"Western Ringtail Possum" |
"Western Small-Footed Myotis" |
"Whale" |
"Whiptail Wallaby" |
"White Rhinoceros" |
"White Tailed Antelope" |
"White Whale" |
"White-Footed Dunnart" |
"White-Footed Mouse" |
"White-Tailed Deer" |
"White-Tailed Dunnart" |
"Wild Ass" |
"Wild Boar" |
"Wild Dog" |
"Wild Horse" |
"Wild Yak" |
"Wildebeest" |
"Wolf" |
"Wolverine" |
"Wombat" |
"Wongai Ningaui" |
"Woodland Caribou" |
"Yak" |
"Yellow Footed Rock Wallaby" |
"Yellow-Bellied glider" |
"Yellow-Bellied Marmot" |
"Yellow-Footed Antechinus" |
"Zebra" |
"Zorilla" |
"Zorro" |
"Almaco Jack" |
"American Eel" |
"American Shad" |
"Angelfish" |
"Arctic Grayling" |
"Arkansas River Shiner" |
"Arowana" |
"Atlantic Croaker" |
"Atlantic Sharpnose Shark" |
"Atlantic Spadefish" |
"Aurora" |
"Bairdiella" |
"Banded Rudderfish" |
"Bank" |
"Bank Sea Bass" |
"Bass" |
"Beautiful Shiner" |
"Betta Splenden" |
"Bigmouth Buffalo" |
"Bigscale Logperch" |
"Black Buffalo" |
"Black Bullhead" |
"Black Crappie" |
"Black Grouper" |
"Black Sea Bass" |
"Blackfin Snapper" |
"Blue Catfish" |
"Blue Marlin" |
"Blue Runner" |
"Blue Sucker" |
"Bluefish" |
"Bluegill" |
"Bluntnose Shiner" |
"Blutnose Minnow" |
"Bocaccio" |
"Bonefish" |
"Bonnethead Shark" |
"Bonytail Chub" |
"Bowfin" |
"Brook Stickleback" |
"Brook Trout" |
"Brown Bullhead" |
"Brown Trout" |
"Bullhead Minnow" |
"Canary" |
"Carp" |
"Catfish" |
"Central Stoneroller" |
"Cero" |
"Cervalle Jack" |
"Chain Pickerel" |
"Channel Catfish" |
"Chihuahua Catfish" |
"Chihuahua Chub" |
"Chilipepper" |
"China" |
"Cichlid" |
"Clownfish" |
"Cobia" |
"Cod" |
"Coelacanth" |
"Coho Salmon" |
"Colorado PikeMinnow" |
"Common Carp" |
"Common Snook" |
"Convict Cichlid" |
"Copper" |
"Cowcod" |
"Creek Chub" |
"Cutthroat Trout" |
"Darkblotched" |
"Darter" |
"Desert Pupfish" |
"Desert Sucker" |
"Discus" |
"Dolphin" |
"Eel" |
"Emerald Shiner" |
"Fantail Mullet" |
"Fat Snook" |
"Fathead Minnow" |
"Flannelmouth Sucker" |
"Flathead Catfish" |
"Flathead Chub" |
"Florida Pompano" |
"Flounder" |
"Flying fish" |
"Freshwater Drum" |
"Gag" |
"Gila Chub" |
"Gizzard Shad" |
"Golden Shiner" |
"Golden Trout" |
"Goldfish Gopher" |
"Grass Carp" |
"Grass Pickerel" |
"Gray Redhorse" |
"Greater Amberjack" |
"Green Sunfish" |
"Greenthroat Darter" |
"Grunion" |
"Gulf Flounder" |
"Gulf Killifish" |
"Guppy" |
"Harlequin" |
"Headwater Catfish" |
"Herring" |
"Hoki" |
"Humpback Chub" |
"Inland Silverside" |
"Iowa Darter" |
"Jewfish" |
"Johnny Darter" |
"Killifish" |
"King Mackerel" |
"Koi" |
"Kokanee Salmon" |
"Ladyfish" |
"Lake Trout" |
"Lamprey" |
"Largemouth Bass" |
"Lesser Amberjack" |
"Little Colorado Spinedace" |
"Livebearer" |
"Loach Minnow" |
"Longbill Spearfish" |
"Longear Sunfish" |
"Longfin Dace" |
"Longjaw MudSucker" |
"Longnose Dace" |
"Longnose Gar" |
"Lungfish" |
"Mahongany Snapper" |
"Mexican Stoneroller" |
"Minnow" |
"Monkey Pupfish" |
"Monkfish" |
"Mooneyes" |
"Mosquitofish" |
"Mottled Sculpin" |
"Mozambique Tilapia" |
"Mutton Snapper" |
"Nassau Grouper" |
"Northern Pike" |
"Orangemouth Corvina" |
"Paddlefish" |
"Palomas Pupfish" |
"Palometa" |
"Pecos Gambusia" |
"Pecos Pupfish" |
"Perch" |
"Phantom Shiner" |
"Pike" |
"Piranha" |
"Plains Killifish" |
"Plains Minnow" |
"Puffer" |
"Pumpkinseed" |
"Pupfish" |
"Queen Snapper" |
"Rainbow Trout" |
"Rainwater Killifish" |
"Ray" |
"Razorback Sucker" |
"Red Grouper" |
"Red Shiner" |
"Red Snapper" |
"Redbelly Dace" |
"Redbelly Tilapia" |
"Redbreast Sunfish" |
"Redear Sunfish" |
"Redeye Bass" |
"Redfin Pickerel" |
"Redside Shiner" |
"Rio Grande Chub" |
"Rio Grande Shiner" |
"River Carp" |
"Rock Bass" |
"Rockfish" |
"Roundnose Minnow" |
"Roundtail Chub" |
"Sacramento Perch" |
"Sailfin Molly" |
"Sailfish" |
"Salmon" |
"Sand Shiner" |
"Sandbar Shark" |
"Sargo" |
"Scalloped Hammerhead" |
"Scamp" |
"Schoolmaster" |
"Sculpin" |
"Seadragon" |
"Seahorse" |
"Shark" |
"Sheepshead" |
"Sheepshead Minnow" |
"Shortfin Maco" |
"Shortfin Molly" |
"Shovelnose sturgeon" |
"Silk Snapper" |
"Silver Perch" |
"Silver SeaTrout" |
"Silvery Minnow" |
"Smallmouth Bass" |
"Smallmouth buffalo" |
"Smelt" |
"Snakehead" |
"Sonora Chub" |
"Sonora Sucker" |
"Spanish Mackerel" |
"Speckled Canadian Chub" |
"Speckled Chub" |
"Speckled Dace" |
"Spikedace" |
"Spotted Bass" |
"Spotted Gar" |
"Spotted Muskellunge" |
"Spotted Seatrout" |
"Spotted Sunfish" |
"Steelhead Trout" |
"Stickleback" |
"Striped Mullet" |
"Sturgeon" |
"Sucker" |
"Suckermouth Minnow" |
"Sunfish" |
"Suwannee Bass" |
"Swordfish" |
"Swordspine Snook" |
"Tamaulipas Shiner" |
"Tarpon" |
"Tarpon Snook" |
"Tench" |
"Threadfin Shad" |
"Tiger Muskellunge" |
"Tilapia" |
"Toothfish" |
"Trout" |
"Tuna" |
"Utah Chub" |
"Variable Platyfish" |
"Vermilion Snapper" |
"Virgin River Chub" |
"Virgin Spinedace" |
"Walking Catfish" |
"Warmouth" |
"White Bass" |
"White Crappie" |
"White Grunt" |
"White Marlin" |
"White Pupfish" |
"White Sucker" |
"Yaqui Catfish" |
"Yaqui Chub" |
"Yaqui Sucker" |
"Yellow Bass" |
"Yellow Bullhead" |
"Yellow Perch" |
"Yellowfin Grouper" |
"Yellowmouth Grouper" |
"Yellowtail Snapper" |
"Zebra Danio" |
"Zebrafish" |
"Zuni Bluehead Sucker" |
"Aphid" |
"Ant" |
"Ant Lion" |
"Bee" |
"Boxelder Bug" |
"Bronze Birch Borer" |
"Cabbage Worm" |
"Carpenter Ant" |
"Carpet Beetle" |
"Centipede" |
"Cicada" |
"Cockroach" |
"Cricket" |
"Cucumber Beetle" |
"Dragonfly" |
"Earwig" |
"Eastern Tent Caterpillar" |
"European Pine Sawfly" |
"Firefly" |
"Flea" |
"Fly" |
"Grain Beetle" |
"Grasshopper" |
"Grub" |
"Gypsy Moth" |
"Hornworm" |
"Japanese Beetle" |
"June Beetle" |
"Katydid" |
"Lacewing" |
"Ladybug" |
"Leafhopper" |
"Lice" |
"Locust" |
"Mantis" |
"Mayfly" |
"Midge" |
"Millipede" |
"Mosquito" |
"Sawfly" |
"Silkworm" |
"Sow Bug" |
"Painted Lady Butterfly" |
"Pantry Pest" |
"Peach Tree Borer" |
"Pill Bug" |
"Silverfish" |
"Slug" |
"Springtails" |
"Squash Bug" |
"Squash Vine Borer" |
"Stag Beetle" |
"Termite" |
"Thrip" |
"Wasp" |
"Water Stider" |
"Water Treader" |
"Whirligig" |
"Whitefly" |
"Winter Moth" |
"Wireworm" |
"Yellow Jacket" |
"Barbary Partridge" |
"Barbet" |
"Barn Owl" |
"Barnacle Goose" |
"Barred Owl" |
"Barred Warbler" |
"Barrows Goldeneye" |
"Bar-Tailed Godwit" |
"Bay-Breasted Warbler" |
"Bean Goose" |
"Bearded Reedling" |
"Bearded Tit" |
"Bearded Vulture" |
"Bee-eater" |
"Bellbird" |
"Bells Vireo" |
"Belted Kingfisher" |
"Bewicks Swan" |
"Bewicks Wren" |
"Bird of paradise" |
"Bittern" |
"Black Grouse" |
"Black Guillemot" |
"Black Kite" |
"Black Redstart"
;

flower_type:
"Acacia Blossom" |
"Allium" |
"Alp Lily" |
"Alpine Aster" |
"Alpine Clover" |
"Alpine Forget Me Not" |
"Alpine Hulsea" |
"Alpine Ragwort" |
"Alpine Saxifrage" |
"Alpine Sorrel" |
"Alpine Spiraea" |
"Alpine Sunflower" |
"Alpine Vetch" |
"Alstroemeria" |
"Alyssum" |
"Amapola" |
"Amaryllis" |
"Ambrosia" |
"American Speedwell" |
"American Twinflower" |
"Anemone" |
"Angelica" |
"Annual Aster" |
"Annual Phlox" |
"Antelope Bitterbrush" |
"Antelope Horns" |
"Anthurium" |
"Arbutus" |
"Arctic Gentian" |
"Arctic Sandwort" |
"Arizona Lupine" |
"Arrowleaf Butterweed" |
"Arrow-Leaved Balsamroot" |
"Arrow-Leaved Thelypody" |
"Aspen" |
"Aster" |
"Autumn Sage" |
"Azalea" |
"Baby Blue Eyes" |
"Baby peppers" |
"Baby's Breath" |
"Bachelor's Button" |
"Bach's Downingia" |
"Back's Sedge" |
"Banksia" |
"Barrett's Penstemon" |
"Basket flower" |
"Beaked Hawksbeard" |
"Bear Grass" |
"Beardtongue" |
"Beautiful Shooting Star" |
"Beggarticks" |
"Begonia" |
"Bellwort" |
"Betony" |
"Bicolored Cluster Lily" |
"Bicolored Lotus" |
"Bigelow Mimulus" |
"Bigelow Monkeyflower" |
"Big-Headed Clover" |
"Big-Leaved Huckleberry" |
"Big-Podded Mariposa Lily" |
"Bilberry" |
"Bird of Paradise" |
"Birds Eye Gilia" |
"Biscuit Root" |
"Bistort" |
"Bitter Cherry" |
"Bitter Vetchling" |
"Bitterroot" |
"Bitterroot Lewisia" |
"Bittersweet" |
"Bittersweet Vine" |
"Black Henbane" |
"Black Knapweed" |
"Black Locust" |
"Black Raspberry" |
"Black Twinberry" |
"Black-Eyed Susan" |
"Blackfoot daisy" |
"Blanket Flower" |
"Blazing Star" |
"Bleeding Heart" |
"Blow Wives" |
"Blue Anemone" |
"Blue boneset" |
"Blue Cup" |
"Blue Curls" |
"Blue Mistflower" |
"Blue Mountain Loco Weed" |
"Blue Mountain Onion" |
"Blue Mountain Penstemon" |
"Blue Mountain Swamp Onion" |
"Blue Oak" |
"Blue Sage" |
"Blue Vine Clematis" |
"Blue Violet" |
"Bluebell" |
"Bluebonnet" |
"Blue-Eyed Grass" |
"Bluets" |
"Bog Asphodel" |
"Bog Buckbean" |
"Bog St. John's Wort" |
"Bog Stitchwort" |
"Bog Wintergreen" |
"Bogbean" |
"Bolander's Hawkweed" |
"Bottle Washer" |
"Bouvardia" |
"Bowl Tubed Iris" |
"Bracted Lousewort" |
"Brass Buttons" |
"Brewer's Cliff Brake" |
"Brewer's Lupine" |
"Brewer's Monkeyflower" |
"Bristly Langloisia" |
"Brittlebush" |
"Broad Flowered Gilia" |
"Broad Leaf Lupine" |
"Broad Leaf Stonecrop" |
"Broad-Leaved Helleborine" |
"Brodiaea" |
"Brooklime" |
"Broom" |
"Broom Buckwheat" |
"Brown Dogwood" |
"Brown-Eyed Susan" |
"Buckbrush" |
"Buckeye" |
"Buckwheat" |
"Buffalo Bur" |
"Bugle" |
"Bull Nettle" |
"Burke's Larkspur" |
"Bush Monkeyflower" |
"Bush Poppy" |
"Bush Sunflower" |
"Butter and Eggs" |
"Butter Lupine" |
"Buttercup" |
"Butterweed" |
"Button Pom" |
"Button Snakeroot" |
"Cactus" |
"Calico Flower" |
"California Black Oak" |
"California Blue-Eyed Grass" |
"California Buckeye" |
"California Buttercup" |
"California Corn Lily" |
"California Fawn Lily" |
"California Fire Chalice" |
"California Golden-eyed Grass" |
"California Indian Pink" |
"California Ladys-Slipper" |
"California Pitcher Plant" |
"California Poppy" |
"California Rose" |
"California Sagebrush" |
"California Saxifrage" |
"Calla Lily" |
"Calliopsis" |
"Calthaleaf Phacelia" |
"Calypso Orchid" |
"Camas" |
"Canada Goldenrod" |
"Canada Thistle" |
"Candytuft" |
"Canon Delphinium" |
"Carey's Balsamroot" |
"Caribea Heliconia" |
"Carnation" |
"Casa Blanca Lily" |
"Cascades Douglasia" |
"Catchfly" |
"Cat's Ear Lily" |
"Cattail" |
"Ceanothus" |
"Centaur Flower" |
"Chaparral Lily" |
"Charming Centaury" |
"Checker Bloom" |
"Cherry Blossom" |
"Chia" |
"Chickweed Wintergreen" |
"Chicory" |
"Chinese Houses" |
"Chrysanthemum" |
"Chuparosa" |
"Cinquefoil" |
"Clarkia" |
"Clasping Leaf Coneflower" |
"Clasping Pepper Grass" |
"Clasping-leaved Twisted Stalk" |
"Cliff Larkspur" |
"Climbing Corydalis" |
"Clustered Broomrape" |
"Clustered Lady's Slipper" |
"Coast Redwood" |
"Coast Sun Cup" |
"Coastal Gumplant" |
"Coastal Tidy Tips" |
"Cockscomb" |
"Colorado Blue Columbine" |
"Coltsfoot" |
"Columbia Desert Parsley" |
"Columbian Coreopsis" |
"Columbian Monkshood" |
"Columbine" |
"Common Blennosperma" |
"Common Cattail" |
"Common Chickweed" |
"Common Cottongrass" |
"Common Cow-Wheat" |
"Common Dandelion" |
"Common Dog Violet" |
"Common Field Speedwell" |
"Common Figwort" |
"Common Fumatory" |
"Common Hareleaf" |
"Common Monkeyflower" |
"Common Prince's Pine" |
"Common Solomon's Seal" |
"Common Sundew" |
"Common Sunflower" |
"Common Toadflax" |
"Common Valerian" |
"Common Water Crowfoot" |
"Common Yellow Monkeyflower" |
"Coneflower" |
"Coreopsis" |
"Corn Mint" |
"Cornflower" |
"Cous" |
"Cow Parsnip" |
"Cowberry" |
"Coyote Mint" |
"Coyotebrush" |
"Cranberry" |
"Cream Cups" |
"Crenulate Moonwort" |
"Creosote Bush" |
"Crimson Columbine" |
"Crocus" |
"Cross-Leaved Heather" |
"Crosswort" |
"Cuckoo Flower" |
"Cup Clover" |
"Curl-Leaf Mountain Mahogany" |
"Cusick's Monkeyflower" |
"Cutleaf Daisy" |
"Cut-Leaved Fleabane" |
"Cyclamen" |
"Daffodil" |
"Dagger Pod Mustard" |
"Daisy" |
"Dakota Vervain" |
"Dalmatian Toad Flax" |
"Damianita" |
"Dandelion" |
"Danny's Skullcap" |
"Dark Woods Violet" |
"Davidson's Penstemon" |
"Day Lily" |
"Death Valley Gilmania" |
"Death Valley Mohavea" |
"Death Valley Phacelia" |
"Delphinium" |
"Delta Arrowhead" |
"Dendrobium Orchid" |
"Desert Aster" |
"Desert Bells" |
"Desert Dandelion" |
"Desert Fivespot" |
"Desert Globemallow" |
"Desert Gold" |
"Desert Goldpoppy" |
"Desert Hibiscus" |
"Desert Indian Paintbrush" |
"Desert Lavender" |
"Desert Lily" |
"Desert Mallow" |
"Desert Paintbrush" |
"Desert Phlox" |
"Desert Plume" |
"Desert Sandverbena" |
"Desert Star" |
"Desert Trumpet" |
"Desert Willow" |
"Desertgold" |
"Desolation Meadow Grapefern" |
"Devil's Scabius" |
"Dewflower" |
"Diffuse Knapweed" |
"Dodder" |
"Douglas' Clover" |
"Douglas Fir" |
"Douglas' Onion" |
"Douglas's Violet" |
"Douglas's Wallflower" |
"Downy Birch" |
"Downy Hemp Nettle" |
"Drought tolerant garden" |
"Drummond Wild Onion" |
"Drummond's Anemone" |
"Dune Evening Primrose" |
"Dusty Maiden" |
"Dutchman's Breeches" |
"Dwarf Cliff Sedum" |
"Dwarf Cornel or Bunchberry" |
"Dwarf Monkeyflower" |
"Eared Willow" |
"Early Blue Violet" |
"Earth Brodiaea" |
"Echium" |
"Elder" |
"Elegant Brodiaea" |
"Elegant Camas" |
"Elegant Death Camas" |
"Elephants Head" |
"Emory's Rock Daisy" |
"Engelmann daisy" |
"Engelmann Spruce" |
"English Daisy" |
"Eremurus" |
"Eriogonum" |
"Eriophyllum" |
"Eryngo" |
"Evening Star" |
"Eyebright" |
"Fairy Bells" |
"Fairy Thimbles" |
"Fairybells" |
"False Garlic" |
"False Hyacinth" |
"False Lily of the Valley" |
"False Lupine" |
"Fan-leaved Cinquefoil" |
"Farewell to Spring" |
"Fern" |
"Fernald's Iris" |
"Fetid Adder's Tongue" |
"Feverfew" |
"Fiddleneck" |
"Field Bindweed" |
"Field Chickweed" |
"Field Mustard" |
"Fiesta Flower" |
"Fine-leaf bluets" |
"Finger Poppy Mallow" |
"Fireweed" |
"Firewheel" |
"Five Point Bishops Cap" |
"Fivespot" |
"Flame Flower" |
"Flax" |
"Fluttermill" |
"Foothill Delphinium" |
"Foothill Penstemon" |
"Forget Me Not" |
"Forsythia" |
"Four-Nerve Daisy" |
"Foxfire" |
"Foxglove" |
"Freesia" |
"Fremont's Camas" |
"Fremont's Pincushion" |
"Fringe Cup" |
"Fringe Pod" |
"Fringed Downingia" |
"Frying Pans" |
"Fuchsia" |
"Fuji Mum" |
"Gardenia" |
"Genistra" |
"Geranium" |
"Gerbera Daisy" |
"Giant Blazing Star" |
"Giant Helleborine Orchid" |
"Giant Hyssop" |
"Giant Trillium" |
"Ginger Lily" |
"Glacier Lily" |
"Gladiolus" |
"Gloriosa Lily" |
"Gloxinia" |
"Goat Willow" |
"Gold Fields" |
"Gold Nuggets" |
"Golden Canbya" |
"Golden Evening Primrose" |
"Golden Fairy Lantern" |
"Golden Fleabane" |
"Golden Nuggets" |
"Goldeneye" |
"Golden-Fruited Sedge" |
"Goldenrod" |
"Goldenwave" |
"Goldfields" |
"Grand Fir" |
"Grand Hounds-Tongue" |
"Grass-of-Parnassus" |
"Gravelghost" |
"Gray Mule Ears" |
"Gray Vervain" |
"Gray Wood-Sorrel" |
"Great Blazingstar" |
"Greater Stitchwort" |
"Green False Hellebore" |
"Green Phacelia" |
"Greenthread" |
"Grey Willow" |
"Ground Cherry" |
"Ground Ivy" |
"Groundsel" |
"Guelder Rose" |
"Hairy Bittercress" |
"Hairy Owl Clover" |
"Hairypetal Hog Fennel" |
"Harebell" |
"Hare's Tail Cottongrass" |
"Harsh Indian Paintbrush" |
"Hawthorn" |
"Hazel" |
"Heart-Leaved Arnica" |
"Heath" |
"Heath Bedstraw" |
"Heath Milkwort" |
"Heath Speedwell" |
"Heath Spotted Orchid" |
"Heather" |
"Hedge Bindweed" |
"Hedge Woundwort" |
"Herb Bennet" |
"Herb Robert" |
"Heron Bill" |
"Hibiscus" |
"Hiker's Gentian" |
"Hogweed" |
"Holly" |
"Honesty" |
"Honeysuckle" |
"Hooker's Fairybell" |
"Hooker's Onion" |
"Horehound" |
"Hounds Tongue" |
"Howell Dimersia" |
"Hudson's Bay Currant" |
"Hyacinth" |
"Hydrangea" |
"Indian blanket" |
"Indian Jasmine" |
"Indian Paintbrush" |
"Indian Pipe" |
"Indigo Bush" |
"Inflated Sedge" |
"Inkberry" |
"Iris" |
"Irish Fleabane" |
"Ironweed" |
"Ivy" |
"Ivy Leaved Bellfower" |
"Ixia" |
"Jack in the Pulpit" |
"James' Saxifrage" |
"Jessica's Stickseed" |
"John Day Valley Desert Parsley" |
"Johnny Jump Up" |
"Jonquil" |
"Joshua Tree" |
"Jumping Cholla" |
"Kangaroo Paw" |
"Kellogg's Monkey Flower" |
"Kern Daisy" |
"Klamath Weed" |
"Klamath Weed" |
"Lace Cactus" |
"Laitris" |
"Larkspur" |
"Laurel" |
"Lavender" |
"Leafy Spurge" |
"Lemon Beebalm" |
"Lemon Mint" |
"Leptospernum" |
"Lesser Calendine" |
"Lewis' Mockorange" |
"Lewis' Monkeyflower" |
"Lilac" |
"Lindheimer Daisy" |
"Lindheimer Senna" |
"Lira de San Pedro" |
"Lisianthus" |
"Little Prince's Pine" |
"Lodgepole Pine" |
"Long-Flowered Bluebells" |
"Long-Headed Coneflower" |
"Lotus" |
"Low Oregon Grape" |
"Low Ruellia" |
"Macdougal's Pincushion" |
"Macfarlane's Four O'Clock" |
"Magnolia" |
"Maguire Lewisia" |
"Maidenhair Fern" |
"Male Fern" |
"Mallow Ninebark" |
"Manzanita" |
"Marigold" |
"Marsh Cinquefoil" |
"Marsh Hawksbeard" |
"Marsh Marigold" |
"Marsh Stitchwort" |
"Marsh Thistle" |
"Marsh Valerian" |
"Marsh Violet" |
"Maximilian Sunflower" |
"Meadow Buttercup" |
"Meadow Foam" |
"Meadow Penstemon" |
"Meadow Pussytoes" |
"Meadow Rue" |
"Meadow Vetchling" |
"Meadowsweet" |
"Mealy Blue Sage" |
"Mealy Sage" |
"Mentzelia" |
"Menzies' Wallflower" |
"Merten's Mountain Heather" |
"Mexican Primrose" |
"Midland Hawthorn" |
"Milk Maids" |
"Miner's Lettuce" |
"Mingan Grapefern" |
"Mini Carnation" |
"Mint" |
"Mission Bells" |
"Missouri Primrose" |
"Mistletoe" |
"Mojave Desert Star" |
"Monkey Flower" |
"Monkshood" |
"Morning Glory" |
"Moss" |
"Moss Campion" |
"Moss Gentian" |
"Moth Mullein" |
"Mountain Ash" |
"Mountain Buttercup" |
"Mountain Dryas" |
"Mountain Grapefern" |
"Mountain Heather" |
"Mountain Lady's Slipper" |
"Mountain Mariposa" |
"Mountain Monardella" |
"Mountain Mule Ears" |
"Mountain Pennyroyal" |
"Mountain Pretty Face" |
"Mountain Pride" |
"Mt. Diablo Globe Tulip" |
"Mule Ears" |
"Munro's Scarlet Globemallow" |
"Musk Mallow" |
"Musk Monkeyflower" |
"Mustang Linanthus" |
"Myrtle" |
"Naked-Stemmed Desert Parsley" |
"Narcissus" |
"Narrlow-leaved Indian Lettuce" |
"Narrowleaf Mules Ears" |
"Narrow-leaved Collomia" |
"Narrowleaved Popcorn Flower" |
"Nasturtium" |
"Needle Navarretia" |
"Nettle" |
"Nevada Primrose" |
"Nipplewort" |
"Northern Fairy Candelabra" |
"Northern Mule's Ears" |
"Northern Starflower" |
"Northern Sweet Vetch" |
"Northern Wyethia" |
"Northwest Balsamroot" |
"Notch leaf Phacelia" |
"Nuttall's Larkspur" |
"Nuttall's Linanthastrum" |
"Oak" |
"Oakland Star Tulip" |
"Ocean Spray" |
"Old plainsman" |
"Oleander" |
"Oncidium Orchid" |
"One-flowered Broomrape" |
"One-flowered Gentian" |
"Onion" |
"Orange Agoseris" |
"Orange Blossom" |
"Orange Honeysuckle" |
"Orange Mock" |
"Orchid" |
"Orcutt's Brodiaea" |
"Oregon Ash" |
"Oregon Bolandra" |
"Oregon Bottle Gentian" |
"Oregon Boxwood" |
"Oregon Lily" |
"Oregon Sidalcea" |
"Oregon Sullivantia" |
"Oregon Sunshine" |
"Oval-leaved Eriogonum" |
"Ox-eye Daisy" |
"Pacific Azelea" |
"Pacific Dogwood" |
"Pacific Madrone" |
"Pacific Rhododendron" |
"Pacific Sedum" |
"Pacific Snakeroot" |
"Pacific Starflower" |
"Pacific Waterleaf" |
"Pacific Yew" |
"Padre Shooting Star" |
"Paintbrush" |
"Pansy" |
"Parakeet Heliconia" |
"Parish Larkspur" |
"Parry's Primrose" |
"Partridge Pea" |
"Passionflower" |
"Pearly Everlasting" |
"Pennell's Penstemon" |
"Penstemon" |
"Peony" |
"Periwinkle" |
"Petty Whin" |
"Petunia" |
"Phacelia" |
"Phalaenopsis Orchid" |
"Phalaenopsis Spray" |
"Phantom Orchid" |
"Pheasant's Eye" |
"Phlox" |
"Pigeon-berry" |
"Pin Cushion Protea" |
"Pine" |
"Pine Broomrape" |
"Pine Drops" |
"Pinedrops" |
"Pink Elephantheads" |
"Pink Evening Primrose" |
"Pink Ginger" |
"Pink Lily" |
"Pink  Fawnlily" |
"Pink Pinwheels" |
"Pink Pussytoes" |
"Pinnate Grapefern" |
"Pioneer Violet" |
"Piper's Windflower" |
"Pitcher Plant" |
"Pitcher sage" |
"Plains black-foot" |
"Plains coreopsis" |
"Plains yellow daisy" |
"Plantain-leaved Buttercup" |
"Poinsettia" |
"Pointed Phlox" |
"Poison Larkspur" |
"Popcorn Flower" |
"Poppy" |
"Porcupine Sedge" |
"Prairie Larkspur" |
"Prairie lily" |
"Prairie Lupine" |
"Prairie spiderwort" |
"Prairie Star" |
"Prickly Pear" |
"Prickly Pear Cactus" |
"Prickly Phlox" |
"Prickly Poppy" |
"Pride of the Mountain" |
"Primrose" |
"Primrose Monkeyflower" |
"Prostrate Milkweed" |
"Protea" |
"Purdy Iris" |
"Purple Candle" |
"Purple Chinese Houses" |
"Purple Coneflower" |
"Purple Leatherflower" |
"Purple Loosestrife" |
"Purple Mat" |
"Purple Nightshade" |
"Purple Owl's Clover" |
"Purple poppy mallow" |
"Purple Sage" |
"Pussy Paws" |
"Queen Anne's Lace" |
"Queencup Beadlily" |
"Rabbitbrush" |
"Ragged Robin" |
"Rain lily" |
"Ramshaw Sandverbena" |
"Ranunculus" |
"Rattlesnake Brome" |
"Rattlesnake Calathium" |
"Red Camellia" |
"Red Campion" |
"Red Clover" |
"Red Elderberry" |
"Red Ginger" |
"Red Kittentail" |
"Red Osier Dogwood" |
"Red-berried Elder" |
"Redwood Sorrel" |
"Ribwort Plantain" |
"Rock Daisy" |
"Rock Penstemon" |
"Rocky Mountain Beeplant" |
"Rose" |
"Rose Sage" |
"Rosebay Willowherb" |
"Rosebud" |
"Rosy Balsamroot" |
"Rosy Plectritis" |
"Rouge-Plant" |
"Roundtooth Ookow" |
"Rowan" |
"Royal Penstemon" |
"Ruby Mountains Primrose" |
"Ruby Sand Spurry" |
"Sabin's Lupine" |
"Sacramento Mountains Prickly Poppy" |
"Sagebrush Buttercup" |
"Salal" |
"Salmonberry" |
"Salt Heliotrope" |
"Sand Blazing Star" |
"Sand Lily" |
"Sand Verbena" |
"Sanicula" |
"Saxifrage" |
"Scabiosa" |
"Scabland Blepharipappus" |
"Scalepod" |
"Scallop Phacelia" |
"Scarlet Fritillary" |
"Scarlet Gaura" |
"Scarlet Gilia" |
"Scarlet Monkey Flower" |
"Scarlet Paintbrush" |
"Scarlet Penstemon" |
"Scentless Mayweed" |
"Scotch Thistle" |
"Seathrift" |
"Seep Spring Monkey Flower" |
"Sego Lily" |
"Selenia" |
"Self Heal" |
"Senecio" |
"Sensitive plant" |
"Serrated-Leaved Balsamroot" |
"Shining Oregon Grape" |
"Shooting Star" |
"Short-flowered Monkeyflower" |
"Showy Milkweed" |
"Showy primrose" |
"Shredding Evening Primrose" |
"Shrubby skullcap" |
"Sickle-leaved Lousewort" |
"Sierra Corydalis" |
"Sierra Crane Orchid" |
"Sierra Evening Primrose" |
"Sierra Onion" |
"Sierra Pea" |
"Sierra Wallflower" |
"Sierran Onion" |
"Sierran Spring Beauty" |
"Silky Phacelia" |
"Silver Birch" |
"Silver Leaf Lupine" |
"Simpson's Ball Cactus" |
"Single Stemmed Groundsel" |
"Siskiyou Fireweed" |
"Sitka Mist Maidens" |
"Skullcap" |
"Skunk Cabbage" |
"Sky Pilot" |
"Sleepy Cat" |
"Slender St. John's Wort" |
"Slinkpod" |
"Small-Flowered Fringecup" |
"Smilax" |
"Smooth Blazingstar" |
"Smooth Hawksbeard" |
"Smooth Sow-Thistle" |
"Smooth Stemmed Fagonia" |
"Snapdragon" |
"Sneezewort" |
"Snow Plant" |
"Snow Willow" |
"Snowdrop Windflower" |
"Snowy Spring Parsley" |
"Solidaster" |
"Spanish Needles" |
"Spencer Primrose" |
"Spicebush" |
"Spider Flower" |
"Spignel" |
"Spinsters Blue-eyed Mary" |
"Spiny Chorizanthe" |
"Spotted Coralroot Orchid" |
"Spotted Langloisia" |
"Spreading Phlox" |
"Spring Whitlow Grass" |
"Sprucebush" |
"Square Mariposa Tulip" |
"Square Petal Primrose" |
"Square-Stemmed Willowherb" |
"Standard Mum" |
"Standing cypress" |
"Standing Wine Cup" |
"Star Gazer Lily" |
"Star of Bethlehem" |
"Statice" |
"Steer's Head" |
"Stemless Evening Primrose" |
"Stephanotis" |
"Stickly Geranium" |
"Sticky Chinese Houses" |
"Sticky Currant" |
"Sticky Penstemon" |
"Sticky Phlox" |
"Stock" |
"Strawberry" |
"Strawtop Cholla" |
"Stream Orchid" |
"Streambank Saxifrage" |
"Striped Coralroot" |
"Sugar Bowls" |
"Sulfur Buckwheat" |
"Sulfur Cinquefoil" |
"Sulphur Flower" |
"Sunflower" |
"Superb Mariposa Tulip" |
"Swale Desert Parsley" |
"Swamp Saxifrage" |
"Sweet Pea" |
"Sweet William Tritoma" |
"Tackstem" |
"Tailcup Lupine" |
"Tall Mountain Bluebells" |
"Tansy" |
"Tansy Ragwort" |
"Teasel" |
"Texas Bluebell" |
"Texas Bluebonnet" |
"Texas Star" |
"Texas Yellow Star" |
"Thelesperma" |
"Thimbleberry" |
"Thin-leaved Owl Clover" |
"Thin-leaved Paintbrush" |
"Thistle" |
"Three-leaf Lewisia" |
"Thyme-leaved Speedwell" |
"Tickseed" |
"Tickseed" |
"Tidytips" |
"Tiny Vetch" |
"Tobacco Brush" |
"Tolmie's Pussy Ears" |
"Tongue Clarkia" |
"Tormentil" |
"Trailing Four O'Clock" |
"Trailing St. John's Wort" |
"Tree Poppy" |
"True Baby Stars" |
"Tufted Evening Primrose" |
"Tufted Phlox" |
"Tulip" |
"Turtleback" |
"Tutsan" |
"Two-eyed Violet" |
"Two-spiked Moonwort" |
"Umatilla Gooseberry" |
"Umbellate Spring Beauty" |
"Utah Honeysuckle" |
"Valley Oak" |
"Venus' Looking Glass" |
"Viburnum" |
"Violet" |
"Violet ruellia" |
"Viscaria" |
"Wakas or Indian Pond Lily" |
"Wake Robin" |
"Wallflower" |
"Wallowa Mountains" |
"Wally Basket" |
"Wandering Daisy" |
"Washington Lily" |
"Washington Monkeyflower" |
"Water Cress" |
"Water Lily" |
"Watsonia" |
"Wavyleaf Ceanothus" |
"Wax Currant" |
"Waxflower" |
"Waxy Sidalcea" |
"Wedelia" |
"Wenaha Currant" |
"Western Bleedingheart" |
"Western Blue Flax" |
"Western Burnet" |
"Western Buttercup" |
"Western Choke Cherry" |
"Western Columbine" |
"Western Corydalis" |
"Western Larch" |
"Western Lily" |
"Western Meadow Rue" |
"Western Pasqueflower" |
"Western Pennyroyal" |
"Western Red Bud" |
"Western Solomon Plume" |
"Western Trillium" |
"Western White Pine" |
"Western Yarrow" |
"Western Yellow Pine" |
"Weston's Mariposa Lily" |
"Whisker Brush" |
"White Alder" |
"White Camellia" |
"White Campion" |
"White Dead-Nettle" |
"White Geranium" |
"White Hyacinth" |
"White Loco" |
"White Mountain Azalea" |
"White Shooting Star" |
"White Trillium" |
"Whitetop" |
"Whitney's Loco Weed" |
"Whorled Solomon's Seal" |
"Wild Carnation" |
"Wild Cauliflower" |
"Wild Cherry" |
"Wild Foxglove" |
"Wild Ginger" |
"Wild Heliotrope" |
"Wild Iris" |
"Wild Paeony" |
"Wild Pansy" |
"Wild Petunia" |
"Wild Strawberry" |
"Wild Tobacco" |
"Wind Poppy" |
"Wind-Flower" |
"Wine Cup" |
"Wintergreen" |
"Wishbone Bush" |
"Wisteria" |
"Wood Buttercup" |
"Wood Cransbill" |
"Wood Lily" |
"Wood Nymph" |
"Wood Sage" |
"Wood Sorrel" |
"Woodland Beardtongue" |
"Woodland Star" |
"Woolly Balsamroot" |
"Woolly ironweed" |
"Woolly Sunflower" |
"Woolly white" |
"Wooly Marbles" |
"Wyoming Paintbrush" |
"Wyoming Paintedcup" |
"Xeranthemum" |
"Yakima Milk Vetch" |
"Yarrow" |
"Yellow Bell" |
"Yellow Flax" |
"Yellow Pimpernel" |
"Yellow Rattle" |
"Yellow Sand Verbena" |
"Yellow Star Thistle" |
"Yerba Santa" |
"Youth on Age" |
"Zinnia";

legal_term:
"Ab Initio" |
"Abbacinare" |
"Abduction" |
"Absolute Divorce" |
"Abstract of Title" |
"Acceleration Clause" |
"Acceptance" |
"Accomplice" |
"Accord and Satisfaction" |
"Accretion" |
"Acquiescence" |
"Acquittal" |
"Act Of God" |
"Action Case" |
"Ad Colligendum Bona" |
"Ad Damnum" |
"Ad Hoc" |
"Ad Infinitum" |
"Ad Litem" |
"Addendum" |
"Additur" |
"Ademption" |
"Adhesion Contract" |
"Adjective Law" |
"Adjudication" |
"Administrative Agencies" |
"Administrative Decision" |
"Administrative Law" |
"Administrative Tribunal" |
"Administrator" |
"Admiralty Law" |
"Admissible Evidence" |
"Admonish" |
"Adultery" |
"Advance Sheet" |
"Adversary Proceeding" |
"Adverse Possession" |
"Affiant" |
"Affidavit" |
"Affirmative Defense" |
"Affirmed" |
"Aggravated Damages" |
"Agreement" |
"Aid and Abet" |
"Alias Summons" |
"Alien" |
"Alimony" |
"Allegation" |
"Alliance" |
"Allodial" |
"Allonge" |
"Alteration" |
"Alternative Dispute Resolution" |
"Amalgamation" |
"Ambassador" |
"Ambulatory" |
"Amicus Curiae" |
"Ancillary" |
"Annotation" |
"Annulment" |
"Answer" |
"Answers To Interrogatories" |
"Antitrust Acts" |
"Appearance" |
"Appellant" |
"Appellate Count" |
"Appendix" |
"Apportionment" |
"Appurtenance" |
"Arbitration" |
"Arbitrator" |
"Arraignment" |
"Arrears" |
"Arrest" |
"Arson" |
"Assault" |
"Assign" |
"Assignment" |
"Assumption Of Risk" |
"At Issue" |
"Attachment" |
"Attorney" |
"Attorney-At-Law" |
"Attorney-In-Fact" |
"Avulsion" |
"Bad Faith" |
"Bailee" |
"Bailiff" |
"Bailment" |
"Bailor" |
"Bankruptcy" |
"Bar Examination" |
"Bare Trust" |
"Barrister" |
"Bastard" |
"Battery" |
"Bench" |
"Bench Trial" |
"Bench Warrant" |
"Beneficiary" |
"Bequeath" |
"Bequests" |
"Berne Convention" |
"Best Evidence" |
"Beyond A Reasonable Doubt" |
"Bigamy" |
"Bill" |
"Bill Of Exchange" |
"Bill Of Lading" |
"Bill Of Particulars" |
"Bind Over" |
"Blind Trust" |
"Blue Book" |
"Bona Vacantia" |
"Bond" |
"Booking" |
"Bound Supplement" |
"Breach Of Contract" |
"Breach Of Trust" |
"Brief" |
"Burden Of Proof" |
"Burglary" |
"Business Bankruptcy" |
"Canon Law" |
"Canons Of Ethics" |
"Capital Crime" |
"Capital Punishment" |
"Case Law" |
"Cause Of Action" |
"Caveat" |
"Censure" |
"Certificate Of Title" |
"Certification" |
"Certiorari" |
"Challenge For Cause" |
"Chambers" |
"Champerty" |
"Change Of Venue" |
"Charge To The Jury" |
"Chaste" |
"Chater" |
"Chattel" |
"Chattel Mortgage" |
"Chief Judge" |
"Child" |
"Chronological" |
"Circumstantial Evidence" |
"Citation" |
"Citators" |
"Civil" |
"Civil Action" |
"Civil Law" |
"Civil Procedure" |
"Claim" |
"Clandestine" |
"Class Action" |
"Clean Hands" |
"Clear And Convincing Evidence" |
"Clemency" |
"Clerk Of Court" |
"Client-Solicitor Privilege" |
"Closing Argument" |
"Codicil" |
"Collate" |
"Collateral" |
"Collateral Descendant" |
"Collective Mark" |
"Collusion" |
"Commission" |
"Commit" |
"Committee" |
"Common Law" |
"Common Share" |
"Commutation" |
"Company" |
"Comparative Fault" |
"Comparative Negligence" |
"Complainant" |
"Complaint" |
"Conciliation" |
"Concurrent Sentences" |
"Condemnation" |
"Condition Precedent" |
"Condition Subsequent" |
"Condonation" |
"Confession" |
"Conformed Copy" |
"Consecutive Sentences" |
"Consent" |
"Consideration" |
"Consign" |
"Conspiracy" |
"Constitution" |
"Constitution" |
"Constitutional Law" |
"Construction" |
"Constructive Dismissal" |
"Constructive Trust" |
"Consumer Bankruptcy" |
"Contempt Of Court" |
"Contingency Fee" |
"Continuance" |
"Contract" |
"Contract Law" |
"Contributory Negligence" |
"Conversion" |
"Conveyance" |
"Conviction" |
"Coparcenaries" |
"Copyright" |
"Coroner" |
"Corporal Punishment" |
"Corporate Secretary" |
"Corporation" |
"Corroborating Evidence" |
"Coservatorship" |
"Costs" |
"Council" |
"Counsel" |
"Counterclaim" |
"Court Martial" |
"Court Of Admiralty" |
"Court Rules" |
"Covenant" |
"Creditor" |
"Crime" |
"Criminal Conversation" |
"Criminal Justice System" |
"Criminal Law" |
"Cross Examination" |
"Cross-Claim" |
"Cumulative Sentences" |
"Custody" |
"Damages" |
"De Bonis Non" |
"De Facto" |
"De Novo" |
"Death Penalty" |
"Debtor" |
"Decapitation" |
"Decision" |
"Declaratory Judgment" |
"Decree" |
"Decree Absolute" |
"Deed" |
"Deem" |
"Defalcation" |
"Defamation" |
"Default" |
"Default Judgment" |
"Defendant" |
"Defense Of Property" |
"Deficient" |
"Defunct" |
"Demand Letter" |
"Demarche" |
"Demurrer" |
"Dependent" |
"Deportation" |
"Deposition" |
"Descendant" |
"Detinue" |
"Devise" |
"Digest" |
"Diplomat" |
"Direct Evidence" |
"Direct Examination" |
"Directed Verdict" |
"Disbarment" |
"Disbursement" |
"Discharge" |
"Disclaim" |
"Discovery" |
"Discretionary Trust" |
"Dismissal" |
"Disrate" |
"Dissent To Disagree" |
"Dissolution" |
"Distraint" |
"Diversion" |
"Diversity Of Citizenship" |
"Dividend" |
"Divorce" |
"DNA" |
"Docket" |
"Docket Number" |
"Doctrine" |
"Domicile" |
"Dominant Tenement" |
"Donee" |
"Donor" |
"Double Jeopardy" |
"Due Process Of Law" |
"Dum Sola" |
"Dum Vidua" |
"Duplex" |
"Duress" |
"Easement" |
"Ecclesiastical Law" |
"Elements Of A Crime" |
"Emancipation" |
"Embargo" |
"Embezzle" |
"Eminent Domain" |
"Emolument" |
"Emphyteusis" |
"Enactment" |
"Encyclopedia" |
"Endorsement" |
"Endowment" |
"Enjoining" |
"Entity" |
"Entrapment" |
"Entry" |
"Environment" |
"Equal Protection Under The Law" |
"Equity" |
"Escheat" |
"Escrow" |
"Esquire" |
"Estate" |
"Estate Law" |
"Estate Tax" |
"Estoppels" |
"Ethics" |
"Euthanasia" |
"Evidence" |
"Ex Parte" |
"Ex Parte Proceeding" |
"Ex Patriate" |
"Ex Rel" |
"Examination-In-Chief" |
"Exceptions" |
"Exclusionary Rule" |
"Exculpate" |
"Execute" |
"Executor" |
"Exempt Property" |
"Exhibit" |
"Exonerate" |
"Express Trust" |
"Expropriation" |
"Expungement" |
"Extortion" |
"Extradition" |
"Fair Market Value" |
"Family Law" |
"Fee Simple" |
"Fee Tail" |
"Felony" |
"Fiduciary" |
"File" |
"Filing Fee" |
"Finding" |
"Foreclosure" |
"Forfeiture" |
"Fraud" |
"Freehold" |
"Fugitive" |
"Fungibles" |
"Garnishment" |
"Gavel" |
"General Counsel" |
"General Jurisdiction" |
"Gift Over" |
"Good Time" |
"Goodwill" |
"Government Printing Office" |
"Grand Jury" |
"Grantor" |
"Grievance" |
"Gross Negligence" |
"Guarantor" |
"Guardian" |
"Guardianship" |
"Guillotine" |
"Habeas Corpus" |
"Habitual Offender" |
"Harassment" |
"Harmless Error" |
"Head Note" |
"Hearing" |
"Hearsay" |
"Holographic Will" |
"Homicide" |
"Hostile Witness" |
"Hung Jury" |
"Husband-Wife Privilege" |
"Immigrants" |
"Immigration" |
"Immunity" |
"Impeachment" |
"Impeachment Of A Witness" |
"Implied Contract" |
"In Re" |
"Inadmissible" |
"Incapacity" |
"Incarceration" |
"Incompetent" |
"Incorporeal" |
"Indefeasible" |
"Independent Executor" |
"Indeterminate Sentence" |
"Indictment" |
"Indigent" |
"Infanticide" |
"Information" |
"Infraction" |
"Inheritance Tax" |
"Initial Appearance" |
"Injunction" |
"Insolvent" |
"Instructions" |
"Intangible Assets" |
"Intentional Tort" |
"Interlocutory" |
"Interrogatories" |
"Intervention" |
"Inure" |
"Involuntary Bankruptcy" |
"Issue" |
"Jactitation" |
"Joint And Several Liability" |
"Joint Custody" |
"Joint Tenancy" |
"Judge" |
"Judgment" |
"Judgment Debtor" |
"Judicial Lien" |
"Judicial Notice" |
"Judicial Review" |
"Judiciary" |
"Juratms" |
"Jure" |
"Jurisdiction" |
"Jurisprudence" |
"Jury" |
"Jus" |
"Justice" |
"Justiciable" |
"Key Number System" |
"Kin" |
"Laches" |
"Landlord" |
"Lapsed Gift" |
"Larceny" |
"Law" |
"Law Blank" |
"Law Clerk" |
"Law Review" |
"Lawsuit" |
"Lawyer" |
"Leading Question" |
"Lease" |
"Leasehold" |
"Legal Aid" |
"Legal Custody" |
"Legal Maxim" |
"Legal Process" |
"Legal Texts" |
"Legislation" |
"Legislative History" |
"Legitimate" |
"Leniency" |
"Letters Of Administration" |
"Letters Testamentary" |
"Lexis" |
"Liability" |
"Liable" |
"Libel" |
"Liberal Construction" |
"License" |
"Licensing Boards" |
"Lien" |
"Life Estate" |
"Life Tenant" |
"Limine" |
"Limited Divorce" |
"Limited Jurisdiction" |
"Limited Partner" |
"Limitrophe" |
"Lineal Descendant" |
"Liquidation" |
"Lis Pendens" |
"Literal Construction" |
"Litigant" |
"Litigation" |
"Livery" |
"Living Trust" |
"Living Will" |
"Loose-Leaf-Services" |
"Magistrate" |
"Magna Carta" |
"Maintenance" |
"Malfeasance" |
"Malicious Prosecution" |
"Malpractice" |
"Mandamus" |
"Manslaughter" |
"Marital Property" |
"Maritime Law" |
"Marshal" |
"Martindale-Hubbell Law" |
"Massachusetts Trust" |
"Master" |
"Matrimony" |
"Mediation" |
"Memorandum" |
"Memorandum Opinion" |
"Memorialized" |
"Mens Rea" |
"Merger" |
"Minor" |
"Minute Book" |
"Minutes" |
"Miranda Warning" |
"Misdemeanor" |
"Misfeasance" |
"Mis-Joinder" |
"Mistrial" |
"Mitigating Circumstances" |
"Mitigation" |
"Mitigation Damages" |
"Mittimus" |
"Modus Operandi" |
"Monopoly" |
"Moot" |
"Moot Court" |
"Moratorium" |
"Motion" |
"Motion In Limine" |
"Murder" |
"Mutual Assent" |
"Nation" |
"National Treatment" |
"Natural Justice" |
"Naturalization" |
"NCND Agreement" |
"Negligence" |
"Negotiate" |
"Negotiation" |
"Next Friend" |
"Next Of Kin" |
"No Bill" |
"No Fault Proceedings" |
"No Jury Trial" |
"No-Contest Clause" |
"Noise Control Act" |
"Nolo Contendere" |
"Nominative Report" |
"Nonfeasance" |
"Notary Public" |
"Notice" |
"Notice To Creditors" |
"Notwithstanding" |
"Novation" |
"Nuisance" |
"Nunc Pro Tunc" |
"Nuncupative Will" |
"Oath" |
"Objection" |
"Obligee" |
"Obligor" |
"Obscenity" |
"Obstructing Justice" |
"Offense" |
"Offer" |
"Official Reports" |
"Ombudsman" |
"Omnibus Bill" |
"On A Person's Own Recognizance" |
"Onus" |
"Open-Ended Agreement" |
"Opening Statement" |
"Opinion" |
"Oral Argument" |
"Order" |
"Ordinance" |
"Orphan" |
"Out-Of-Court Settlement" |
"Overrule" |
"Paperbound Supplement" |
"Par Value Shares" |
"Paralegal" |
"Parallel Citation" |
"Pardon" |
"Parens Patriae" |
"Parole" |
"Parole Evidence" |
"Parricide" |
"Partnership" |
"Party" |
"Patent" |
"Patent And Trademark Office" |
"Paternity" |
"Payee" |
"Payor" |
"Pedophile" |
"Pen Register" |
"Per Curiam Opinion" |
"Per Se Doctrine" |
"Peremptory Challenge" |
"Perjury" |
"Permanent Injunction" |
"Permanent Law" |
"Perpetuity" |
"Person" |
"Person In Need Of Supervision" |
"Personal Property" |
"Personal Representative" |
"Petition" |
"Petitioner" |
"Pettifogger" |
"Physical Custody" |
"Picket" |
"Plaintiff" |
"Plea" |
"Plea Bargaining" |
"Pleadings" |
"Poach" |
"Pocket Parts" |
"Polling The Jury" |
"Polygamy" |
"Polygraph" |
"Postal Rule" |
"Post-Trial" |
"Pour-Over Will" |
"Power" |
"Power Of Attorney" |
"Precatory Words" |
"Precedent" |
"Preferred Shares" |
"Preinjunction" |
"Preliminary Hearing" |
"Preponderance" |
"Prescription" |
"Presentence Report" |
"Presentment" |
"Presumption Of Advancement" |
"Pretermitted Child" |
"Pretrial Conference" |
"Prima Facie Case" |
"Primary Authority" |
"Primary Sources" |
"Principal" |
"Private Law" |
"Privilege" |
"Pro Bono" |
"Pro Forma" |
"Pro Rata" |
"Pro Se" |
"Pro Socio" |
"Pro Tempore" |
"Probable Cause" |
"Probate" |
"Probate Court" |
"Probate Estate" |
"Probation" |
"Procedural Law" |
"Product Liability" |
"Prohibition" |
"Promisee" |
"Promisor" |
"Promissory Estoppels" |
"Promissory Note" |
"Property" |
"Property Tax" |
"Propinquity" |
"Propound" |
"Proprietor" |
"Prosecute" |
"Prosecutor" |
"Prospectus" |
"Prostitute" |
"Proximate Cause" |
"Proxy" |
"Public Defender" |
"Public Domain" |
"Public Law" |
"Public Law" |
"Public Service Commission" |
"Puisne" |
"Punitive Damages" |
"Purchase Agreement" |
"Purchase Offer" |
"Putative" |
"Quantum" |
"Quantum Meruit" |
"Quash" |
"Quasi-Contract" |
"Quasi-Criminal Action" |
"Quasi-Judicial" |
"Quid Pro Quo" |
"Quiet Title Action" |
"Quitclaim Deed" |
"Quo Warranto" |
"Quorum" |
"Ransom" |
"Ratio Decidendi" |
"Real Property" |
"Reasonable Doubt" |
"Reasonable Person" |
"Rebut" |
"Rebuttable Presumption" |
"Recognizance" |
"Record" |
"Recuse" |
"Redemption" |
"Re-Direct Examination" |
"Redress" |
"Referee" |
"Registered Mark" |
"Regulation" |
"Rehearing" |
"Rejoinder" |
"Relator" |
"Remainder" |
"Remand" |
"Remedy" |
"Remittitur" |
"Removal" |
"Rent" |
"Replacement Volumes" |
"Replevin" |
"Reply" |
"Reporters" |
"Request For Admission" |
"Request For Production Of Documents" |
"Request To Admit" |
"Res Gestae" |
"Rescind" |
"Rescission" |
"Research" |
"Resolution" |
"Respondent" |
"Rest" |
"Restatement" |
"Restitution" |
"Resulting Trust" |
"Retainer" |
"Return" |
"Reverse" |
"Reversible Error" |
"Reversion" |
"Revocable Trust" |
"Revoke" |
"Right Of Way" |
"Robbery" |
"Robinson-Patman" |
"Rules" |
"Rules Of Evidence" |
"Sanction" |
"Sanctuary" |
"Scienter" |
"Seal" |
"Search Warrant" |
"Secondary Authority" |
"Secured Debts" |
"Seisin" |
"Self Defense" |
"Self Incrimination" |
"Self Providing Will" |
"Sentence" |
"Sentence Report" |
"Sequester" |
"Sequestration Of Witnesses" |
"Service Process" |
"Servient Tenement" |
"Session Law" |
"Settlement" |
"Settlor" |
"Sexual Intercourse" |
"Share" |
"Shareholder Agreement" |
"Shepardizing" |
"Sheriff" |
"Sherman Act" |
"Sidebar" |
"Silent Partner" |
"Sine Die" |
"Slander" |
"Slander Of Title" |
"Slip Opinion" |
"Small Business Association" |
"Small Claims Court" |
"Socage" |
"Social Security" |
"Social Security Tax" |
"Sodomy" |
"Solicitor" |
"Sovereign" |
"Sovereign Immunity" |
"Specific Performance" |
"Speedy Trial Act" |
"Spendthrift Trust" |
"Split Custody" |
"Spouse" |
"Standard Of Proof" |
"Standing" |
"Standing Committee" |
"Stare Dicisis" |
"State" |
"Status Offenders" |
"Statute" |
"Statute Of Limitations" |
"Statutory" |
"Statutory Construction" |
"Statutory Law" |
"Statutory Research" |
"Statutory Trust" |
"Stay" |
"Stipulation" |
"Strict Liability" |
"Strike" |
"Sub Judice" |
"Subinfeudation" |
"Subject Research" |
"Subpoena" |
"Subpoena Duces Tecum" |
"Subrogation" |
"Subservient Treatment" |
"Substantive Criminal Law" |
"Substantive Law" |
"Summary Judgment" |
"Summons" |
"Support Trust" |
"Suppress" |
"Surety Bond" |
"Survivorship" |
"Suspension" |
"Sustain" |
"Synallagmatic Contract" |
"Table Of Cases" |
"Tamper" |
"Taxable Income" |
"Temporary Law" |
"Temporary Relief" |
"Temporary Restraining Order" |
"Tender Of Performance" |
"Tenement" |
"Tenure" |
"Testamentary Capacity" |
"Testamentary Trust" |
"Testator" |
"Testimony" |
"Third Party Complaint" |
"Title" |
"Torrens Land Registration System" |
"Tort" |
"Tracing" |
"Trademark" |
"Transcript" |
"Transmittal Form" |
"Treatise" |
"Treaty" |
"Trespass" |
"Trial" |
"Trial Brief" |
"Trover" |
"Trust" |
"Trust Agreement" |
"Trust Declaration" |
"Trustee" |
"Truth In Lending" |
"Uncontested Divorce" |
"Unfair Labor Practice" |
"Uniform Laws" |
"Unilateral Contract" |
"Union" |
"Unjust Enrichment" |
"Unlawful Detainer" |
"Unliquidated Debt" |
"Unofficial Reports" |
"Unsecured Debts" |
"Urban" |
"Use And Possession" |
"Usury" |
"Vacate" |
"Vagrant" |
"Vendor" |
"Venire" |
"Venue" |
"Verdict" |
"Vicarious Liability" |
"Visa" |
"Void" |
"Voidable" |
"Voir Dire" |
"Voluntary Bankruptcy" |
"Wage Earner's Plan" |
"Wagner Act" |
"Waiver" |
"Waiver Of Immunity" |
"Warrant" |
"Warranty" |
"Warranty Deed" |
"Waste" |
"Water Rights" |
"Wedlock" |
"Will" |
"Wire-Tapping" |
"With Prejudice Witness" |
"Withholding" |
"Without Prejudice" |
"Witness" |
"Words Of Limitation" |
"Words Of Purchase" |
"Writ" |
"Writ Of Centiorari" |
"Writ Of Execution" |
"Writ Of Garnishment" |
"Wrongful Death" |
"Wrongful Dismissal" |
"Yellow Dog Contract" |
"Young Offender" |
"Zipper" |
"Zoning Commission"
;

culinary_term:
"A La Boulangere" |
"A La Carte" |
"A La Creole" |
"A La Diable" |
"A La King" |
"A La Marechale" |
"A La Mode" |
"A La Nicoise" |
"A La Printanier" |
"A La Provencale" |
"A La Russe" |
"A L'Anglais" |
"Abalone" |
"Aboyeur" |
"Acetic Acid" |
"Acetomel" |
"Achar" |
"Achard" |
"Achira" |
"Acid" |
"Acid Rinse" |
"Acidulated Water" |
"Acorn Squash" |
"Ade" |
"Adjust" |
"Adobo" |
"Adulterated Food" |
"Aemono" |
"Aerobic Bacteria" |
"After Taste" |
"Agar-Agar" |
"Aging" |
"Aiguillettes" |
"AToli" |
"Aji-No-Motto" |
"Akavit" |
"Al Carbon" |
"Al Dente" |
"Al Dente" |
"Al Forno" |
"Al Fresco" |
"Al Pastor" |
"Alambre" |
"Albondigas" |
"Albumin" |
"Ale" |
"Alkali" |
"All-Purpose Flour" |
"Allspice" |
"Allumette" |
"Almond Extract" |
"Almond Paste" |
"Alumettes" |
"Aluminum Foil" |
"Amandine" |
"Amaretto" |
"Ambrosia" |
"Amino Acid" |
"Amuse-Guele" |
"Anadama Bread" |
"Anaerobic Bacteria" |
"Anchovy" |
"Anchovy Paste" |
"Andouille" |
"Angel Food Cake" |
"Angel Hair Pasta" |
"Angelica" |
"Anise" |
"Anisette" |
"Annatto Extract" |
"Anolini" |
"Antioxidants" |
"Antipasto" |
"Aperitif" |
"Appareil" |
"Appetizer" |
"Apple" |
"Apple Butter" |
"Applemint" |
"Apricot" |
"Aqua Vitae" |
"Aquaculture" |
"Arborio" |
"Arborio Rice" |
"Areca Nut" |
"Aroma" |
"Aromatic" |
"Aromatics" |
"Aromatized Wine" |
"Arrack" |
"Arrowroot" |
"Arroz" |
"Artichoke" |
"Arugula" |
"As Purchased Weight" |
"Asiago Cheese" |
"Asian Pear" |
"Asparagus" |
"Aspic" |
"Athol Brose" |
"Au Bleu" |
"Au Gratin" |
"Au Jus" |
"Au Naturel" |
"Avocado" |
"Baba" |
"Babka" |
"Baby Back Ribs" |
"Backribs" |
"Bacon" |
"Bacteria" |
"Bagel" |
"Baguette" |
"Bain-Marie" |
"Bake" |
"Bake Blind" |
"Bake Cups" |
"Baking Powder" |
"Baking Soda" |
"Baklava" |
"Bamboo Shoot" |
"Banana" |
"Banana Squash" |
"Bannock" |
"Barbecue" |
"Bard" |
"Barding" |
"Barley" |
"Barley Flour" |
"Barm Brack" |
"Barquette" |
"Basil" |
"Basmati" |
"Baste" |
"Batch Cooking" |
"Baton" |
"Batonnet" |
"Batter" |
"Bavarian Cream" |
"Bay Leaves" |
"Bean Curd" |
"Bearnaise" |
"Beat" |
"Bechamel" |
"Beef" |
"Beer" |
"Beet" |
"Bell Pepper" |
"Bench-Proof" |
"Benedictine" |
"Benne" |
"Beta Carotene" |
"Beurre Blanc" |
"Beurre Fondue" |
"Beurre Manie" |
"Bibb Lettuce" |
"Bind" |
"Binder" |
"Biscuit" |
"Bisque" |
"Bite-Size" |
"Bitters" |
"Bivalve" |
"Black Bean" |
"Black Butter" |
"Blackberry" |
"Black-Eyed Pea" |
"Blanc" |
"Blanch" |
"Blancmange" |
"Blanquette" |
"Blend" |
"Blini" |
"Bloom" |
"Blue Cheese" |
"Blue Crab" |
"Blueberry" |
"Body" |
"Boil" |
"Bok Choy" |
"Bologna" |
"Bombes" |
"Bonbon" |
"Bone-In" |
"Boneless" |
"Borscht" |
"Boston Baked Beans" |
"Botulism" |
"Boucher" |
"Bouef" |
"Bouillabaisse" |
"Bouillon" |
"Boulanger" |
"Bouquet Garni" |
"Braise" |
"Bran" |
"Bran" |
"Brandy" |
"Brazier" |
"Brazil Nuts" |
"Bread" |
"Breadfruit" |
"Breast" |
"Bresaola" |
"Brick Cheese" |
"Brie Cheese" |
"Brigade" |
"Brigade Systems" |
"Brine" |
"Brioche" |
"Brisket" |
"Broccoli" |
"Broccoli Rabe" |
"Brochette" |
"Broil" |
"Broiler" |
"Bromated Flour" |
"Broth" |
"Brown Rice" |
"Brown Sauce" |
"Brown Stock" |
"Brown Sugar" |
"Brownie" |
"Bruise" |
"Brunoise" |
"Bruschetta" |
"Brush" |
"Brussels Sprouts" |
"Buckwheat" |
"Buerre Noir" |
"Buerre Noisette" |
"Buffet" |
"Bulger" |
"Bundt Pan" |
"Burrito" |
"Butcher" |
"Butter" |
"Butter Lettuce" |
"Buttercream" |
"Butterfly" |
"Buttermilk" |
"Butternut Squash" |
"Butterscotch" |
"Cabbage" |
"Cabrito" |
"Cacciatore" |
"Cafe" |
"Caffeine" |
"Cajun" |
"Cake" |
"Cala" |
"Calabash" |
"Calcium" |
"Caldillo" |
"Calorie" |
"Calorie Free" |
"Calzone" |
"Camembert Cheese" |
"Canadian Bacon" |
"Canape" |
"Canard" |
"Candele Pasta" |
"Candy Thermometer" |
"Cane Syrup" |
"Cannellini Beans" |
"Canning Funnel" |
"Canola Oil" |
"Cantaloupe" |
"Capellini" |
"Capicolla" |
"Capon" |
"Caponata" |
"Cappuccino" |
"Caprini" |
"Capsaicin" |
"Caramel" |
"Caraway Seeds" |
"Carbohydrate" |
"Carbon Dioxide" |
"Carmelization" |
"Carne Asada" |
"Carry-Over-Cooking" |
"Casing" |
"Casserole" |
"Cassoulet" |
"Caul Fat" |
"Cellulose" |
"Cephalopod" |
"Chafing Dish" |
"Champagne" |
"Charcutiere" |
"Chateaubriande" |
"Chaud-Froid" |
"Cheesecloth" |
"Chef De Partie" |
"Chef De Rang" |
"Chef De Salle" |
"Chef De Service" |
"Chef De Vin" |
"Chemical Leavener" |
"Cherrystone" |
"Chiffon" |
"Chiffonade" |
"Chile" |
"Chili" |
"Chili Powder" |
"Chine" |
"Chinois" |
"Cholesterol" |
"Chop" |
"Choucroute" |
"Chowder" |
"Ciguatera Toxin" |
"Cioppino" |
"Clarification" |
"Clarified Butter" |
"Coagulation" |
"Coarse Chop" |
"Cocoa" |
"Cocotte" |
"Coddled Eggs" |
"Colander" |
"Collagen" |
"Combination Method" |
"Commis" |
"Communard" |
"Complete Protein" |
"Complex Carbohydrate" |
"Composed Salad" |
"Compote" |
"Compound Butter" |
"Concasse" |
"Condiment" |
"Conduction" |
"Confiserie" |
"Confit" |
"Conquilles St. Jacques" |
"Consomme" |
"Convection" |
"Convection Oven" |
"Converted Rice" |
"Coral" |
"Cornichon" |
"Cornstarch" |
"Cottage Cheese" |
"Coulis" |
"Country-Style" |
"Court Boullion" |
"Couscous" |
"Couscoussier" |
"Couverture" |
"Cream" |
"Cream Cheese" |
"Cream Of Tartar" |
"Cream Puff" |
"Cream Soup" |
"Creme Anglais" |
"Creme Brulee" |
"Creme Fraiche" |
"Creme Patissiere" |
"Creole" |
"Crepe" |
"Croissant" |
"Cross Contamination" |
"Croustade" |
"Crouton" |
"Crumb" |
"Crustacean" |
"Cuisson" |
"Curd" |
"Cure" |
"Curing Salt" |
"Curry" |
"Custard" |
"Daily Values" |
"Danger Zone" |
"Danish Pastry" |
"Daube" |
"Debeard" |
"Deck Oven" |
"Deep Fry" |
"Deep Poach" |
"Deglaze" |
"Degrease" |
"Demiglace" |
"Depouilage" |
"Deviled" |
"Dice" |
"Die" |
"Digestif" |
"Direct Heat" |
"Dock" |
"Dore" |
"Drawn" |
"Dredge" |
"Dressed" |
"Drum Sieve" |
"Dry Cure" |
"Dry Saute" |
"Dumplings" |
"Durum" |
"Dusting" |
"Dutch Oven" |
"Dutch Process" |
"Duxelles" |
"Eclair" |
"Edible-Portion Weight" |
"Egg Wash" |
"Emincer" |
"Emulsion" |
"Endosperm" |
"Entrecote" |
"Entremetier" |
"Escalope" |
"Espagnole Sauce" |
"Essence" |
"Estouffade" |
"Ethylene Gas" |
"Etouffe" |
"Evaporated Milk" |
"Extrusion" |
"Fabrication" |
"Faculative Bacteria" |
"Farce" |
"Farina" |
"Fat" |
"Fatback" |
"Fermentation" |
"Fiber" |
"File" |
"Filet" |
"Fillet" |
"Fillet Mignon" |
"Fines Herbes" |
"First In" |
"Fish Poacher" |
"Five-Spice Powder" |
"Flatfish" |
"Flattop" |
"Fleurons" |
"Foaming Method" |
"Foie Gras" |
"Fold" |
"Fond" |
"Fondant" |
"Food Cost" |
"Food Mill" |
"Food Processor" |
"Food-Borne Illness" |
"Forcemeat" |
"Fork-Tender" |
"Formula" |
"Fortified Wine" |
"Free-Range" |
"Frenching" |
"Fricassee" |
"Fritter" |
"Friturier" |
"Fructose" |
"Fumet" |
"Galantine" |
"Ganache" |
"Garbure" |
"Garde Manger" |
"Garni" |
"Gazpacho" |
"Gelatin" |
"Gelatinization" |
"Genois" |
"Germ" |
"Gherkin" |
"Giblits" |
"Glace" |
"Glaze" |
"Glucose" |
"Gluten" |
"Goujon" |
"Grand Sauce" |
"Gratin" |
"Gravlax" |
"Griddle" |
"Grill" |
"Grill Pan" |
"Grillardin" |
"Grissini" |
"Griswold" |
"Gumbo" |
"Haricot" |
"Hash" |
"Heimlich Maneuver" |
"High-Ratio Cake" |
"Hollandaise" |
"Hollow-Ground" |
"Hominy" |
"Homogenization" |
"Hors-D'Oeuvre" |
"Hotel Pan" |
"Hydrogenation" |
"Hydroponics" |
"Hygiene" |
"Induction Burner" |
"Infection" |
"Infusion" |
"Instant-Reading Themometer" |
"Intoxication" |
"Inventory" |
"Invert Sugar" |
"Jardiniere" |
"Julienne" |
"Jus" |
"Jus Lie" |
"Kasha" |
"Knead" |
"Kosher" |
"Kosher Salt" |
"Lactose" |
"Laminate" |
"Lard" |
"Lardon" |
"Leavener" |
"Lecithin" |
"Legume" |
"Liaison" |
"Liqueur" |
"Littleneck" |
"Low-Fat Milk" |
"Lox" |
"Lozenge Cut" |
"Lyonnaise" |
"Macaroon" |
"Madeira" |
"Maillard Reaction" |
"Maitre D'Hotel" |
"Mandonline" |
"Marbling" |
"Marinade" |
"Marzipan" |
"Matelote" |
"Matignon" |
"Mayonnaise" |
"Mechanical Leavener" |
"Medallion" |
"Meringue" |
"Mesophilic" |
"Metabolism" |
"Meuniere" |
"Microwave Oven" |
"Mie" |
"Millet" |
"Milling" |
"Mince" |
"Mineral" |
"Minestrone" |
"Minute" |
"Mirepoix" |
"Mise En Place" |
"Molasses" |
"Mollusk" |
"Monosodium Glutamate" |
"Monounsaturated Fat" |
"Monte Au Beurre" |
"Mousse" |
"Mousseline" |
"Napolean" |
"Nappe" |
"Nature" |
"Navarin" |
"New Potato" |
"Noisette" |
"Nouvelle Cuisine" |
"Nutrient" |
"Nutrition" |
"Oblique Cut" |
"Offal" |
"Offset Spatula" |
"Oignon Brule" |
"Oignon Pique" |
"Omelet" |
"Organ Meat" |
"Organic Leavener" |
"Over Spring" |
"Paella" |
"Paillard" |
"Palette Knife" |
"Pan Frying" |
"Pan Gravy" |
"Pan-Broiling" |
"Panda" |
"Pan-Dressed" |
"Pan-Steaming" |
"Par Stock" |
"Parchment" |
"Parcook" |
"Parisienne Scoop" |
"Pasta" |
"Pasteurization" |
"Pastry Bag" |
"Pate" |
"Pate A Choux" |
"Pate Brisee" |
"Pate De Campagne" |
"Pate En Croute" |
"Pate Feuilletee" |
"Pate Sucree" |
"Pathogen" |
"Patissier" |
"Paupiette" |
"Paysanne" |
"Peel" |
"Pesto" |
"Petit Four" |
"PH Scale" |
"Phyllo Dough" |
"Physical Leavener" |
"Pickling Spice" |
"Pilaf" |
"Pince" |
"Pluches" |
"Poach" |
"Poele" |
"Poissonier" |
"Polenta" |
"Polyunsaturated" |
"Port" |
"Pot-Au-Feu" |
"Prawn" |
"Presentation Side" |
"Pressure Steamer" |
"Primal Cut" |
"Printaniere" |
"Prix Fixe" |
"Proof" |
"Prosciutto" |
"Protein" |
"Provencale" |
"Pulse" |
"Puree" |
"Quahog" |
"Quatre Epices" |
"Quenelle" |
"Quick Breads" |
"Raft" |
"Ragout" |
"Ramekin" |
"Reach-In-Refrigerator" |
"Reduce" |
"Reduction" |
"Refresh" |
"Remouillage" |
"Render" |
"Rest" |
"Rich Dough" |
"Rillet" |
"Ring-Top" |
"Risotto" |
"Roast" |
"Roll-In" |
"Rondeau" |
"Rondelle" |
"Rotisseur" |
"Roulade" |
"Round" |
"Round Fish" |
"Roux" |
"Royale" |
"Rub" |
"Sabayon" |
"Sachet D' Epices" |
"Saffron" |
"Salt Cod" |
"Saltpeter" |
"Sambuca" |
"Sanitize" |
"Sashimi" |
"Saturated Fat" |
"Sauce" |
"Sauce Vin Blanc" |
"Saucier" |
"Sausage" |
"Saute" |
"Sauteuse" |
"Sautoir" |
"Savory" |
"Scald" |
"Scale" |
"Scaler" |
"Scallop" |
"Scampi" |
"Scone" |
"Score" |
"Scrapple" |
"Sea Salt" |
"Sear" |
"Seasoning" |
"Semolina" |
"Shallow-Poach" |
"Sheet Pan" |
"Shelf Life" |
"Shellfish" |
"Sherry" |
"Shirred Eggs" |
"Sieve" |
"Silverskins" |
"Simmer" |
"Simple Carbohydrate" |
"Simple Syrup" |
"Single-Stage Technique" |
"Skim" |
"Skim Milk" |
"Slurry" |
"Small Sauce" |
"Smoke Roasting" |
"Smoker" |
"Smoking" |
"Smoking Point" |
"Smother" |
"Soba Noodle" |
"Sodium" |
"Sommelier" |
"Sorbet" |
"Souffle" |
"Sourdough" |
"Sous Chef" |
"Soy Sauce" |
"Spa Cooking" |
"Spatzle" |
"Spice" |
"Spider" |
"Spit-Roast" |
"Sponge" |
"Sponge Cake" |
"Springform Pan" |
"Stabilizer" |
"Standard Breading Proceedure" |
"Staphylococcus Aureus" |
"Steak" |
"Steamer" |
"Steaming" |
"Steam-Jacket Kettle" |
"Steel" |
"Steep" |
"Stew" |
"Stir Frying" |
"Stock" |
"Stockpot" |
"Stone-Ground" |
"Straight" |
"Straight Mix Method" |
"Strain" |
"Supreme" |
"Sweat" |
"Sweetbreads" |
"Swiss" |
"Syrup" |
"Tabbouleh" |
"Table D'Hote" |
"Table Salt" |
"Table Wine" |
"Tagine" |
"Tagliarini" |
"Tahini" |
"Tamalley" |
"Tamarind" |
"Tart" |
"Tartare" |
"Temper" |
"Tempura" |
"Tenderloin" |
"Terrine" |
"Thermophilic" |
"Thickener" |
"Tilting Kettle" |
"Timbale" |
"Tiramisu" |
"Tofu" |
"Tomato Sauce" |
"Tortellini" |
"Tortelloni" |
"Tortilla" |
"Total Utilization" |
"Tournant" |
"Tourner" |
"Tourte" |
"Toxin" |
"Tranche" |
"Trash Fish" |
"Trichinella Spiralis" |
"Tripe" |
"Truffle" |
"Truss" |
"Tuber" |
"Tuile" |
"Tumeric" |
"Tunneling" |
"Tzatziki Sauce" |
"Tzimmes" |
"Udon" |
"Ugli" |
"Umami" |
"Univalve" |
"Unsaturated Fat" |
"Vacherin" |
"Vanilla" |
"Vanilla Sauce" |
"Variety Meat" |
"Vegetable Soup" |
"Vegetarian" |
"Veloute" |
"Venison" |
"Vermicelli" |
"Vertical Chopping Machine" |
"Vichyssoise" |
"Victual" |
"Vinaigrette" |
"Virus" |
"Vitamins" |
"Vitello Tonnato" |
"Vol-Au-Vent" |
"Waffle" |
"Walk-In-Refrigerator" |
"Wasabi" |
"Waterbath" |
"Waterzooi" |
"Welsh Rarebit" |
"Whelk" |
"Whey" |
"Whip" |
"White Chocolate" |
"White Mirepoix" |
"White Stock" |
"Whole Grain" |
"Whole-Wheat Flour" |
"Wiener Schnitzel" |
"Wok" |
"Worcestershire Sauce" |
"Xanthan Gum" |
"Yakitori" |
"Yam" |
"Yeast" |
"Yogurt" |
"Zabaglione" |
"Zakuski" |
"Zampone" |
"Zest" |
"Zuccotto" |
"Zuppa Inglese"
;

people_adjective:
"Bad" |
"Jittery" |
"Purple" |
"Tan" |
"Better" |
"Jolly" |
"Quaint" |
"Tender" |
"Beautiful" |
"Kind" |
"Quiet" |
"Testy" |
"Big" |
"Long" |
"Quick" |
"Tricky" |
"Black" |
"Lazy" |
"Quickest" |
"Tough" |
"Blue" |
"Bright" |
"Magnificent" |
"Magenta" |
"Rainy" |
"Rare" |
"Ugly" |
"Ugliest" |
"Clumsy" |
"Many" |
"Ratty" |
"Vast" |
"Crazy" |
"Mighty" |
"Red" |
"Watery" |
"Dizzy" |
"Mushy" |
"Roasted" |
"Wasteful" |
"Dull" |
"Nasty" |
"Robust" |
"Wide-Eyed" |
"Fat" |
"New" |
"Round" |
"Wonderful" |
"Frail" |
"Nice" |
"Sad" |
"Yellow" |
"Friendly" |
"Nosy" |
"Scary" |
"Yummy" |
"Cantankerous" |
"Funny" |
"Nutty" |
"Scrawny" |
"Zany" |
"Great" |
"Nutritious" |
"Short" |
"Green" |
"Odd" |
"Silly" |
"Gigantic" |
"Orange" |
"Stingy" |
"Gorgeous" |
"Ordinary" |
"Strange" |
"Grumpy" |
"Pretty" |
"Striped" |
"Handsome" |
"Precious" |
"Spotty" |
"Happy" |
"Prickly" |
"Tart" |
"Horrible" |
"Tall" |
"Itchy" |
"Tame" |
"Big-Headed" |
"Two-Faced"
;

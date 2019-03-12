require_relative('models/bounty')

bounty1 = Bounty.new({'name'=>'Han', 'bounty_value'=>'500', 'homeworld'=>'unknown', 'favourite_weapon'=>'laser gun'})
bounty2 = Bounty.new({'name'=>'Luke', 'bounty_value'=>'1000', 'homeworld'=>'Tatooine', 'favourite_weapon'=>'lightsaber'})
bounty3 = Bounty.new({'name'=>'Han', 'bounty_value'=>'1000', 'homeworld'=>'Tatooine', 'favourite_weapon'=>'lightsaber'})

# Bounty.delete_all
bounty1.save
bounty3.save
bounty2.save

# bounty2.name = 'Obi Wan'
# bounty2.update

# result = Bounty.find_by_name('Charlie')
# p result

result = Bounty.find_by_id(23)
p result

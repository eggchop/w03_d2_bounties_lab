require 'pg'

class Bounty
  attr_accessor :name, :bounty_value, :homeworld, :favourite_weapon
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @bounty_value = options['bounty_value'].to_i
    @homeworld = options['homeworld']
    @favourite_weapon = options['favourite_weapon']
  end

  def save
    db = PG.connect({dbname: 'bounty_tracker', host: 'localhost'})
    sql = "INSERT INTO bounties (name, bounty_value, homeworld, favourite_weapon)
    VALUES ($1,$2,$3,$4) RETURNING *;"

    values = [@name,@bounty_value,@homeworld,@favourite_weapon]

    db.prepare("save", sql)
    bounty_array =db.exec_prepared("save", values)
    @id = bounty_array[0]['id']
    db.close
  end

  def delete
    db = PG.connect({dbname: 'bounty_tracker', host: 'localhost'})
    sql = "DELETE FROM bounties WHERE id = $1;"

    values = [@id]

    db.prepare("delete", sql)
    db.exec_prepared("delete", values)
    db.close
  end

  def Bounty.delete_all
    db = PG.connect({dbname: 'bounty_tracker', host: 'localhost'})
    sql = "DELETE FROM bounties;"
    db.prepare("delete", sql)
    db.exec_prepared("delete")
    db.close
  end

  def update
    db = PG.connect({dbname: 'bounty_tracker', host: 'localhost'})
    sql = "UPDATE bounties SET (name, bounty_value,homeworld,favourite_weapon) = ($1,$2,$3,$4) WHERE id=$5;"

    values = [@name,@bounty_value,@homeworld,@favourite_weapon,@id]

    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close
  end

  def Bounty.find_by_name(name)
    db = PG.connect({dbname: 'bounty_tracker', host: 'localhost'})
    sql = "SELECT * FROM bounties WHERE name = $1;"

    values = [name]

    db.prepare('find_by_name', sql)
    bounty_hash = db.exec_prepared('find_by_name', values)
    db.close

    return bounty_hash.map{|hash| Bounty.new(hash)}[0]
  end

  def Bounty.find_by_id(id)
    db = PG.connect({dbname: 'bounty_tracker', host: 'localhost'})
    sql = "SELECT * FROM bounties WHERE id = $1;"

    values = [id]

    db.prepare('find_by_id', sql)
    bounty_hash = db.exec_prepared('find_by_id', values)
    db.close

    return Bounty.new(bounty_hash[0])
  end
end

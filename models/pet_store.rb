require_relative('../db/sql_runner')

class PetStore

  attr_reader :id
  attr_accessor :name, :address

  def initialize(options)
    @id = options['id'].to_i if options['id'] != nil
    @name = options['name']
    @address = options['address']
  end

  def save
    sql = "INSERT INTO pet_store (name, address) VALUES ('#{@name}', '#{@address}') RETURNING *"
    pet_store = SqlRunner.run(sql).first
    @id = pet_store['id'].to_i
  end

  def list_of_pets
    sql = "SELECT * FROM pets WHERE pet_store_id = #{@id}"
    pets = SqlRunner.run(sql)
    result = pets.map { |pet| Pet.new(pet) }
    return result
  end

  def self.list_of_all_stores
    sql = "SELECT * FROM pet_store"
    pet_stores = SqlRunner.run(sql)
    result = pet_stores.map { |store| PetStore.new(store)}
    return result
  end

  def self.delete_store(pet_store_id)
    sql = "DELETE FROM pet_store WHERE id = #{pet_store_id}"
    SqlRunner.run(sql)
  end

  def find_by_id(pet_store_id)
    sql = "SELECT * FROM pet_store WHERE id = #{pet_store_id}"
    pet_store = SqlRunner.run(sql).first
    return pet_store
  end

  def update
    sql = "UPDATE pet_store SET 
      name = '#{ @name }',
      address = '#{ @address }'
      WHERE id = #{@id};"
    SqlRunner.run(sql)
    return nil
  end


end
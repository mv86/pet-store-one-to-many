require_relative('../db/sql_runner')

class Pet

  attr_reader :id, :pet_store_id
  attr_accessor :name, :type

  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
    @type = options['type']
    @pet_store_id = options['pet_store_id'].to_i
  end

  def save
    sql = "INSERT INTO pets (name, type, pet_store_id) VALUES ('#{@name}', '#{@type}', #{@pet_store_id}) RETURNING *"
    pet = SqlRunner.run(sql).first
    @id = pet ['id'].to_i
  end 

  def self.delete_pet(id)
    sql = "DELETE FROM pets WHERE id = #{id}"
    SqlRunner.run(sql)
  end

  # def list_of_pet_s
  #   sql = "SELECT * FROM pets WHERE pet_store_id = #{@id}"
  #   pets = SqlRunner.run(sql)
  #   result = pets.map { |pet| Pets.new(pet) }
  #   return result
  # end
  def update
    sql = "UPDATE pets SET 
      name = '#{ @name }',
      type = '#{ @type }'
      WHERE id = #{@id};"
    SqlRunner.run(sql)
    return nil
  end

  def belongs_to
    sql = "SELECT * FROM pet_store WHERE id = #{@pet_store_id}"
    pet_store = SqlRunner.run(sql).first
    return PetStore.new(pet_store)
  end

  # def artist
  #   sql = "SELECT * FROM artists WHERE id = #{@artist_id}"

  #   artist = SqlRunner.run(sql).first
  #   result = Artist.new(artist)
  #   return result
  # end

end
require 'csv' 
CSV.foreach(Rails.root.join('lib/beer-tinder-seeds-040723.csv'), headers: true) do |row|
    Beer.create({
        name: row["name"],
        brewery: row["brewery"], 
        abv: row["abv"], 
        ibu: row["ibu"], 
        variety: row["variety"],
        img: row["img"],
        description: row["description"]
    })
    p "added beer"
end


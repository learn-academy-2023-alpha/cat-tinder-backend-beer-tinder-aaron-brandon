require 'csv' 
CSV.foreach(Rails.root.join('lib/beer-seed.csv'), headers: true) do |row|
    Beer.create({
        name: row["name"],
        brewery: row["brewery"], 
        abv: row["abv"], 
        ibu: row["ibu"], 
        primary_flavor: row["primary_flavor"], 
        secondary_flavor: row["secondary_flavor"],
        color: row["color"],
        variety: row["variety"]
    })
    p "added beer"
end


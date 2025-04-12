json.extract! synonym, :id, :boardid, :answer, :image, :status, :created_at, :updated_at
json.url synonym_url(synonym, format: :json)
json.image url_for(synonym.image)

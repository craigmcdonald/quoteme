module QuoteMe

  class Insurer

    include FieldSet
    include FindCollection

    field :name
    field :covers
    
  end


end
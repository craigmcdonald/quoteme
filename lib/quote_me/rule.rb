module QuoteMe

  class Rule 

    include FieldSet
    include FindCollection

    field :covers
    field :position
    field :multiply

  end

end
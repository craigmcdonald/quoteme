module QuoteMe

  class Recipient
    
    include FieldSet

    field :name
    field :notify_to
    field :notify_by

  end

end
class Coach < ApplicationRecord

    has_secure_password
    has_secure_token :confirmation_token
    validates :username,
     format:{with: /\A[a-zA-Z0-9_]{2,20}\z/, message: "le nom d'utilisateur ne doit contenir que des caractères aplhanumériques ou des _"},
      uniqueness: {case_sensitive: false}
    
    validates :email,
     format: {with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/},
     uniqueness: {case_sensitive: false}

     validates :firstname,
     format: {with: /\A[a-z]+$\z/, message: "ne peut contenir que des lettres en minuscules"} 

     validates :lastname,
     format: {with: /\A^[a-z]+$\z/, message: "ne peut contenir que des lettres en minuscules"} 

    def to_session

      {id: id}
    
    end


end

class Coach < ApplicationRecord

    attr_accessor :photo_file

    has_secure_password
    has_secure_token :confirmation_token

    has_many :programmes
    
    after_save :photo_upload
    before_save :photo_before_upload
    after_destroy_commit :photo_destroy

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

     validates :phone_number,
     format: {with: /\A^[0-9]*$\z/, message: "ne peut contenir que des chiffres"}

     validates :photo_file, file: {ext: [:jpg, :png]}

    def to_session
      {id: id}
    end


    def photo_path
      File.join(Rails.public_path, self.class.name.downcase.pluralize, id.to_s,'photo.jpg')
    end


    def photo_url
      '/' + [self.class.name.downcase.pluralize, id.to_s, 'photo.jpg'].join('/')
    end


    def photo_upload
      
      path = photo_path

      if photo_file.respond_to? :path
        dir = File.dirname(path)
        FileUtils.mkdir_p(dir) unless Dir.exist?(dir)
        
        image = MiniMagick::Image.new(photo_file.path) do |b|

          b.resize '150x150'
          b.gravity 'Center'
          b.crop '150x150+0+0'
        end

        image.format 'jpg'
        image.write path
      end

    end


    def photo_before_upload
      if photo_file.respond_to? :path
        self.photo = true
      end
    end

    
  def photo_destroy
    dir = File.dirname(photo_path)

    FileUtils.rm_r(dir) if Dir.exist?(dir)

  end
    
end

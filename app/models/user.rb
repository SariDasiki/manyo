class User < ApplicationRecord
    has_secure_password
    has_many :tasks, dependent: :destroy

    before_update :admin_cannot_update
    before_destroy :admin_cannot_delete
    
    before_validation { email.downcase! }
    
    validates :name, presence: true
    validates :email, presence: true
    validates :email, uniqueness: true 
    validates :email, uniqueness: { case_sensitive: false }
    validates :password, length: { minimum: 6 }
    validates :password_digest, presence: true

    private

    def admin_cannot_update
        admin_user_size = User.where(admin:true).size
        
        if admin_user_size == 1 && self.changes["admin"] == [true, false]
            self.errors.add :base, "管理者が0人になるため権限を変更できません"
        throw :abort
        end  
    end
      
    def admin_cannot_delete
    #   今の管理者の人数が何人いるか調べる
      admin_user_size = User.where(admin:true).size
      
      if admin_user_size == 1 && self.admin
        self.errors.add :base, "管理者が0人になるため削除できません"
        throw :abort
      end
    end

end

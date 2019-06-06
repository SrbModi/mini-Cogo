#constants is created as wee need constatns for services
#

module Constants #module is a combonation of classes
  PER_PAGE_LIMIT = 10

  class UserStatusType
    include Ruby::Enum

    define :ACTIVE, 'active'
    define :INACTIVE, 'inactive'
  end

end
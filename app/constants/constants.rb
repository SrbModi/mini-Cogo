#constants is created as wee need constatns for services
#

module Constants #module is a combonation of classes
  PER_PAGE_LIMIT = 10

  class UserStatusType
    include Ruby::Enum

    define :ACTIVE, 'active'
    define :INACTIVE, 'inactive'
  end

  class LocationType
    include Ruby::Enum
    define :CONTINENT, 'continent'
    define :PINCODE, 'pincode'
    define :REGION, 'region'
    define :CLUSTER, 'cluster'
    define :CITY, 'city'
    define :PORT, 'port'
    define :TRADE, 'trade'
    define :COUNTRY, 'country'
  end

  class BookingStatus
    include Ruby::Enum
    define :BOOKED, 'booked'
    define :IN_PROCESS, 'in_process'
    define :COMPLETED, 'completed'
  end

end
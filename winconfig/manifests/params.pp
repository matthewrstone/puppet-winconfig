# Windows Configuration Base Parameters
class winconfig::params{
    if versioncmp($::operatingsystemrelease, 6.1) < 0 {
      fail('Windows 2003 is not supported...')
  } else {
      info('Operating System is Windows 2008 or newer.  Proceeding...')
  }
}
Feature: Remove RPMs by pkgspec


Background: Install glibc
  Given I use the repository "dnf-ci-fedora"
   When I execute dnf with args "install glibc"
   Then the exit code is 0
    And Transaction is following
        | Action        | Package                                   |
        | install       | setup-0:2.12.1-1.fc29.noarch              |
        | install       | filesystem-0:3.9-2.fc29.x86_64            |
        | install       | basesystem-0:11-6.fc29.noarch             |
        | install       | glibc-0:2.28-9.fc29.x86_64                |
        | install       | glibc-common-0:2.28-9.fc29.x86_64         |
        | install       | glibc-all-langpacks-0:2.28-9.fc29.x86_64  |


Scenario Outline: Remove an RPM by <pkgspec-type>
   When I execute dnf with args "remove <pkgspec>"
   Then the exit code is 0
    And Transaction is following
        | Action        | Package                                   |
        | remove        | setup-0:2.12.1-1.fc29.noarch              |
        | remove        | filesystem-0:3.9-2.fc29.x86_64            |
        | remove        | basesystem-0:11-6.fc29.noarch             |
        | remove        | glibc-0:2.28-9.fc29.x86_64                |
        | remove        | glibc-common-0:2.28-9.fc29.x86_64         |
        | remove        | glibc-all-langpacks-0:2.28-9.fc29.x86_64  |

@tier1
Examples: Name
  | pkgspec-type                    | pkgspec                       |
  | name                            | glibc                         |

Examples: Other pkgspecs
  | pkgspec-type                    | pkgspec                       |
  | name-version                    | glibc-2.28                    |
  | name-version-release            | glibc-2.28-9.fc29             |
  | name-version-release.arch       | glibc-2.28-9.fc29.x86_64      |
  | name-epoch:version-release.arch | glibc-0:2.28-9.fc29.x86_64    |
  | name.arch                       | glibc.x86_64                  |
  | name containing dashes          | glibc-common                  |
  | pkgspec contining wildcards     | glibc-*.x86_64                |

﻿#requires -Version 2 -Modules Pester

Describe 'New-NuGetPackageVersion' {
    Context 'When IsDefaultBranch is true' {
        It 'should return the Version' {
            New-NuGetPackageVersion -Version '1.2.3.4' -IsDefaultBranch $True -BranchName 'master' | Should Be '1.2.3.4'
        }
    }
    Context 'When IsDefaultBranch is false' {
        it 'should throw when BranchName is empty' {
            { New-NuGetPackageVersion -Version '1.2.3.4' -IsDefaultBranch $False -BranchName '' } | Should Throw
        }
        it 'should use the BranchName and revision number as the pre-release suffix' {
            New-NuGetPackageVersion -Version '1.2.3.4' -IsDefaultBranch $False -BranchName 'SomeBranch' | Should Be '1.2.3-SomeBranch4'
        }
        it 'should shorten the pre-release suffix (by removing vowels) if the BranchName is too long' {
            New-NuGetPackageVersion -Version '1.2.3.4' -IsDefaultBranch $False -BranchName 'SomeBranchNameThatsTooLong' | Should Be '1.2.3-SmBrnchNmThtsTLng4'
        }
        it 'should shorten the pre-release suffix (by removing vowels and then truncating) if the BranchName is too long' {
            New-NuGetPackageVersion -Version '1.2.3.4' -IsDefaultBranch $False -BranchName 'SomeBranchNameThatsReallyFarTooLong' | Should Be '1.2.3-SmBrnchNmThtsRllyF4'
        }
    }
}

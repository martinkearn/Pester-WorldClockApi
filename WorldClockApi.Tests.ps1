Describe 'Test worldclockapi.com' {
    BeforeAll {
        $response = Invoke-WebRequest -Method 'GET' -Uri 'http://worldclockapi.com/api/json/utc/now'
        $responseContent = $response.Content | ConvertFrom-Json
        $dayOfWeek = (Get-Date).DayOfWeek
        $year = Get-Date -Format "yyyy"
        $month = Get-Date -Format "MM"
    }

    It "It should respond with 200" {
        $response.StatusCode | Should -Be 200
    }

    It "It should have a null service response" {
        $responseContent.serviceResponse | Should -BeNullOrEmpty
    } 

    It "It should be $dayOfWeek" {
        $responseContent.dayOfTheWeek | Should -Be $dayOfWeek
    }

    It "It should be year $year" {
        $responseContent.currentDateTime | Should -BeLike "*$year*"
    }

    It "It should be month $month" {
        $responseContent.currentDateTime | Should -BeLike "*$month*"
    }

    # Assumes you are running this outside daylight savings .. hacky but good way to showcase the syntax ;)
    It "It should not be daylight savings time" {
        $responseContent.isDayLightSavingsTime | Should -Not -Be $true
    }

    It "It should not be daylight savings time another way" {
        $responseContent.isDayLightSavingsTime | Should -BeFalse
    }
}
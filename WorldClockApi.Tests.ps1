Describe 'Test worldclockapi.com' {
    BeforeAll {
        $response = Invoke-WebRequest -Method 'GET' -Uri 'http://worldclockapi.com/api/json/utc/now'
        $responseContent = $response.Content | ConvertFrom-Json
    }

    It "It should respond with 200" {
        $response.StatusCode | Should -Be 200
    }
    
    It "It should have a null service response" {
        $responseContent.serviceResponse | Should -BeNullOrEmpty
    } 
    
    It "It should be the right day of the week" {
        $dayOfWeek = (Get-Date).DayOfWeek
        $responseContent.dayOfTheWeek | Should -Be $dayOfWeek
    }
    
    It "It should be the right year" {
        $year = Get-Date -Format "yyyy"
        $responseContent.currentDateTime | Should -BeLike "*$year*"
    }
    
    It "It should be the right month" {
        $month = Get-Date -Format "MM"
        $responseContent.currentDateTime | Should -BeLike "*$month*"
    }
    
    # These two tests assume you are running this outside daylight savings (during the winter) .. hacky but good way to showcase the syntax ;)
    It "It should not be daylight savings time" {
        $responseContent.isDayLightSavingsTime | Should -Not -Be $true
    }
    
    It "It should not be daylight savings time another way" {
        $responseContent.isDayLightSavingsTime | Should -BeFalse
    }
}
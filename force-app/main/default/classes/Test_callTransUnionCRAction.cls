@isTest
global class Test_callTransUnionCRAction {
    
    @isTest
    static void testSoapCallout_Success() {
        // Test data
        List<String> CreditOutput = new List<String>{'SSNNumber%%%123456789',
                                                     'FirstName%%%John',
                                                     'LastName%%%Doe',
                                                     'Apartmentnumber%%%Apt 123',
                                                     'Street%%%Main St',
                                                     'City%%%Springfield',
                                                     'State%%%IL',
                                                     'PostalCode%%%12345',
                                                     'RecordId%%%003an000001LvIrAAK'};

        // Set up mock response for success
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());

        // Start test execution
        Test.startTest();
        // Call the method under test
        List<String> result = callTransUnionCRAction.callTransUnionCR(CreditOutput);
        // Stop test execution
        Test.stopTest();

        // Assertions
        System.assertEquals(1, result.size(), 'Expected only one result');
        // Add more assertions as needed
    }

    @isTest
    static void testSoapCallout_Error() {
        // Test data
        List<String> CreditOutput = new List<String>{'SSNNumber%%%123456789',
                                                     'FirstName%%%John',
                                                     'LastName%%%Doe',
                                                     'Apartmentnumber%%%Apt 123',
                                                     'Street%%%Main St',
                                                     'City%%%Springfield',
                                                     'State%%%IL',
                                                     'PostalCode%%%12345',
                                                     'RecordId%%%003an000001LvIrAAK'};

        // Set up mock response for error
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGeneratorError());

        // Start test execution
        Test.startTest();
        // Call the method under test
        List<String> result = callTransUnionCRAction.callTransUnionCR(CreditOutput);
        // Stop test execution
        Test.stopTest();

        // Assert that ErrorMsgs list is returned
        System.assertNotEquals(null, result, 'Error should be returned');
        //System.assert(result.size() > 0, 'Error should be added to ErrorMsgs');
    } 

    // Mock HTTP response generator for success
    public class MockHttpResponseGenerator implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'text/xml');
            res.setBody('<response><results>+750</results><transactionTimeStamp>2024-04-05T12:00:00Z</transactionTimeStamp><embeddedData>fake embedded data</embeddedData><error>null</error><description>Error message</description></response>');
            res.setStatusCode(200);
            return res;
        }
    }

    // Mock HTTP response generator for error
    public class MockHttpResponseGeneratorError implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'text/xml');
            res.setBody('<error><description>Error occurred</description></error>');
            res.setStatusCode(500);
            res.setStatus('500 Internal Server Error'); 
            return res;
        }
    }
}
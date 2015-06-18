//
//  FISGithubAPIClientSpec.m
//  github-repo-list
//
//  Created by Joe Burgess on 5/6/14.
//  Copyright 2014 Joe Burgess. All rights reserved.
//

#import "Specta.h"
#define EXP_SHORTHAND
#define HC_SHORTHAND
#define MOCKITO_SHORTHAND
#import "FISGithubRepository.h"

#import <KIF/KIF.h>
#import <Expecta.h>
#import "FISGithubAPIClient.h"
#import <OHHTTPStubs.h>
#import <OCHamcrest/OCHamcrest.h>
#import <OCMockito/OCMockito.h>

SpecBegin(FISGithubAPIClient)

describe(@"FISGithubAPIClient", ^{
    
    __block NSArray *repositoryArray;
    NSString *fullName = @"wycats/merb-core";
//    beforeAll(^{
//        [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
//            if ([request.URL.host isEqualToString:@"api.github.com"]&&[request.URL.path isEqualToString:@"/repositories"])
//            {
//                return YES;
//            }
//            else
//            {
//                return NO;
//            }
//        } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
//            return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFileInBundle(@"repositories.json", nil) statusCode:200 headers:@{@"Content-Type": @"application/json"}];
//        }];
//        
       //
//        // mock creation
//        FISGithubRepository *mockRepo = mock([FISGithubRepository class]);
//        
//        // using mock object
//        [mockArray removeAllObjects];
//        
//        // verification
//        [verify(mockArray) addObject:@"one"];
//        [verify(mockArray) removeAllObjects];
    //    });
    
    describe(@"repositories", ^{
        context(@"exist", ^{
            
            waitUntil(^(DoneCallback done) {
                
                NSData *data = [NSData dataWithContentsOfFile:OHPathForFileInBundle(@"repositories.json", nil)];
                repositoryArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                
                
                [FISGithubAPIClient getRepositoriesWithCompletion:^(NSArray *repoDictionaries) {
                    it(@"should return a dictionary of repositories", ^{
                        expect(repoDictionaries).to.equal(repositoryArray);
                    });
                    
                    done();
                }];
                
            });
            
            it(@"is starred", ^{
                
                waitUntil(^(DoneCallback done) {
                    [FISGithubAPIClient checkIfRepoIsStarredWithFullName:fullName CompletionBlock:^(BOOL starred) {
                        expect(starred).to.beTruthy(); //Check that the correct Request was called
                        done();
                    }];
                });
            });
            
            it(@"is not starred", ^{
                waitUntil(^(DoneCallback done) {
                    [FISGithubAPIClient checkIfRepoIsStarredWithFullName:fullName CompletionBlock:^(BOOL starred) {
                        expect(starred).to.beFalsy(); //Check that the correct Request was called
                        done();
                    }];
                });
            });
        });
    });
    context(@"does not exist", ^{
        // find a way to fake an internet outage.
    });
    
    describe(@"starring a repository", ^{
        waitUntil(^(DoneCallback done) {
            __block BOOL calledGithubAPI=NO;
            
            [FISGithubAPIClient starRepoWithFullName:fullName CompletionBlock:^{
                expect(calledGithubAPI).will.beTruthy(); //Check that the correct request was sent
                done();
            }];
        });
        
    });
    
    describe(@"unstarring a repository", ^{
        waitUntil(^(DoneCallback done) {
            __block BOOL calledGithubAPI=NO;
            
            [FISGithubAPIClient unstarRepoWithFullName:fullName
                                       CompletionBlock:^{
                                           expect(calledGithubAPI).will.beTruthy(); //Check that the correct request was sent
                                           
                                           done();
                                       }];
        });
        
    });
    
    
    
    describe(@"Star Repo", ^{
        it(@"should star the repo",  ^{
        });
    });
    
    describe(@"Unstar Repo", ^{
        it(@"Should unstar the repo",  ^{
        });
    });
});

SpecEnd

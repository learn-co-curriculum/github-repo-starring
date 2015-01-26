//
//  FISGithubAPIClient.m
//  github-repo-list
//
//  Created by Joe Burgess on 5/5/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import "FISGithubAPIClient.h"
#import "FISConstants.h"

@implementation FISGithubAPIClient
NSString *const GITHUB_API_URL=@"https://api.github.com";

+(void)getRepositoriesWithCompletion:(void (^)(NSArray *))completionBlock
{
    NSString *githubURL = [NSString stringWithFormat:@"%@/repositories?client_id=%@&client_secret=%@",GITHUB_API_URL,GITHUB_CLIENT_ID,GITHUB_CLIENT_SECRET];

    NSURLSession *urlSession = [NSURLSession sharedSession];
    
    NSURLRequest *repoRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:githubURL]];
    
    NSURLSessionDataTask *task = [urlSession dataTaskWithRequest:repoRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (!error) {
            
            NSArray *dataFromTask = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            completionBlock(dataFromTask);
        }
        else {
            NSLog(@"Fail: %@",error.localizedDescription);
        }
    }];
    
    [task resume];
}

+(void)checkIfRepoIsStarredWithFullName:(NSString *)fullName CompletionBlock:(void (^)(BOOL))completionBlock
{
    NSString *url = [NSString stringWithFormat:@"%@/user/starred/%@?access_token=%@",GITHUB_API_URL,fullName, GITHUB_ACCESS_TOKEN];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];

    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
        BOOL success=NO;
        if (!error) {
            if (httpResponse.statusCode == 204 ) {
                success=YES;
                
            }
        }
        
        completionBlock(success);
    }];
    
    //    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
//    AFHTTPRequestSerializer *serializer = [[AFHTTPRequestSerializer alloc] init];
//    [serializer setAuthorizationHeaderFieldWithUsername:GITHUB_ACCESS_TOKEN password:@""];
//    manager.requestSerializer = serializer;
//
//    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
//       
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
//        
//    }];
    
    [task resume];
}

+(void)starRepoWithFullName:(NSString *)fullName CompletionBlock:(void (^)(void))completionBlock
{
    
    NSString *url = [NSString stringWithFormat:@"%@/user/starred/%@?access_token=%@",GITHUB_API_URL,fullName, GITHUB_ACCESS_TOKEN];
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    request.HTTPMethod = @"PUT";
    request.HTTPBody = [NSJSONSerialization dataWithJSONObject:@{@"Content-Length":@0}
                                                       options:0 error:nil];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            completionBlock();
        }
        else {
            NSLog(@"FAIL:%@",error.localizedDescription);
        }
    }];
    
    
//    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
//    AFHTTPRequestSerializer *serializer = [[AFHTTPRequestSerializer alloc] init];
//    [serializer setAuthorizationHeaderFieldWithUsername:GITHUB_ACCESS_TOKEN password:@""];
//    manager.requestSerializer = serializer;
//
//    [manager PUT:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        completionBlock();
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        
//    }];
    
    [task resume];
}

+(void)unstarRepoWithFullName:(NSString *)fullName CompletionBlock:(void (^)(void))completionBlock
{
    NSString *url = [NSString stringWithFormat:@"%@/user/starred/%@?access_token=%@",GITHUB_API_URL,fullName, GITHUB_ACCESS_TOKEN];
 
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    request.HTTPMethod = @"DELETE";
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            completionBlock();
        }
        else {
            NSLog(@"FAIL:%@",error.localizedDescription);
        }
    }];
    

    [task resume];
    
//    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
//    AFHTTPRequestSerializer *serializer = [[AFHTTPRequestSerializer alloc] init];
//    [serializer setAuthorizationHeaderFieldWithUsername:GITHUB_ACCESS_TOKEN password:@""];
//    manager.requestSerializer = serializer;
//
//    [manager DELETE:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        completionBlock();
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        
//    }];
}

@end

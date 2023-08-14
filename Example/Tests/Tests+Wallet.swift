//
//  Tests+Wallet.swift
//  FncyWallet_Tests
//
//  Created by 박종혁 on 2023/08/14.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import XCTest
import FncyWallet

final class Tests_Wallet: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    let authToken = "588120bf928d9662b01990cc01fca29b21d4e4bc305b7a3b6f195cfee5ec0fcd4922"
    
    // MARK: - 지갑 만들기
    
    // MARK: 지갑 만들기 유닛 테스트
        
    // 지갑 생성
    func testWalletAPI_makeWallet() async throws {
        let authToken2 = "588120bf928d9662b01990cc01fca29b21d4e4bc305b7a3b6f195cfee5ec0fcd5111"
        
        let fncyWallet = FncyWalletCore(authToken: authToken2)
        
        let walletNm : String = "cortana"
        let userPin : String = "666666"
        do {
            let result = try await fncyWallet.makeWallet(walletNm: walletNm,
                                                         pinNumber: userPin)
            print("Success")
            print(String(describing: result))
        } catch {
            print("testWalletAPI Error cases : ", String(describing: error))
        }
        
//        {
//          "wid" : 10681,
//          "result" : {
//            "number" : 200,
//            "code" : "SUCCESS",
//            "message" : "Success",
//            "isSuccess" : true
//          },
//          "resultType" : "WalletInsertResultCodes"
//        }
        
//        {
//          "resultType" : "WalletInsertResultCodes",
//          "result" : {
//            "message" : "FORBIDDEN: 이미 지갑을 등록한 사용자",
//            "code" : "REGISTERED_USER_WALLET",
//            "isSuccess" : false,
//            "number" : 403
//          },
//          "wid" : 0
//        }
    }
    
    // 지갑 복원 키 추가
    func testWalletAPI_postRegisterRestorationKey() async throws {
        let authToken2 = "588120bf928d9662b01990cc01fca29b21d4e4bc305b7a3b6f195cfee5ec0fcd5111"
        let fncyWallet = FncyWalletCore(authToken: authToken2)
        
        let wid = 10681
        let questionSeq : Int = 47
        let answer : String = "모모"
        let userPin : String = "666666"
        
        do {
            let result = try await fncyWallet.postRegisterRestorationKey(wid: wid,
                                                                         questionSeq: questionSeq,
                                                                         answer: answer,
                                                                         pinNumber: userPin)
            print("Success")
            print(String(describing: result))
        } catch {
            print("testWalletAPI Error cases : ", String(describing: error))
        }
//        {
//          "resultType" : "WalletInsertResultCodes",
//          "result" : {
//            "isSuccess" : true,
//            "code" : "SUCCESS",
//            "number" : 200,
//            "message" : "Success"
//          }
//        }
        
//        {
//          "result" : {
//            "code" : "REGISTERED_USER_WALLET",
//            "message" : "FORBIDDEN: 이미 지갑을 등록한 사용자",
//            "number" : 403,
//            "isSuccess" : false
//          },
//          "resultType" : "WalletInsertResultCodes"
//        }
        
        
    }
    // 지갑 비밀번호 확인
    func testWalletAPI_checkWalletPin() async throws {
        let fncyWallet = FncyWalletCore(authToken: authToken)
        let pinString = "666666"
        do {
            let result = try await fncyWallet.checkWalletPin(pinNumber: pinString)
            print("Success")
            print(String(describing: result))
        } catch {
            print("testWalletAPI Error cases : ", String(describing: error))
        }
    }
    // 지갑 생성 - 복원용 질문 목록
    func testWalletAPI_getQuestionList() async throws {
        let fncyWallet = FncyWalletCore(authToken: authToken)
        do {
            let result1 = try await fncyWallet.getQuestionList(pageNo: 1)
            let result2 = try await fncyWallet.getQuestionList(pageNo: 2)
            let result3 = try await fncyWallet.getQuestionList(pageNo: 3)
            
            print(result1)
            print(result2)
            print(result3)
            XCTAssert(true)
            
        } catch(let error) {
            XCTAssert(false, String(describing: error))
        }
    }
    // 지갑 복구 질문답변 확인
    func testWalletAPI_checkResetAnswer() async throws {
        let fncyWallet = FncyWalletCore(authToken: authToken)
        let answer = "모모"
        do {
            let result = try await fncyWallet.checkResetAnswer(answer: answer)
            print("Success")
            print(String(describing: result))
            
        } catch(let error) {
            print("testWalletAPI Error cases")
            print(String(describing: error))
        }
//        {
//          "result" : {
//            "code" : "SUCCESS",
//            "message" : "Success",
//            "isSuccess" : true,
//            "number" : 200
//          },
//          "resultType" : "WalletAuthenticationCheckResultCodes"
//        }
        
        // fail
//        ResultData(resultType: "WalletAuthenticationCheckResultCodes", result: SDKTutorial.ResultInfo(message: "FORBIDDEN: 질문 답변이 일치하지 않음", code: "MISS_MATCH_USER_ANSWER", isSuccess: false, number: 403))
    }
    
    
    
    // MARK: - 지갑(지갑 수정)✅
    // 핀번호 변경
    func testWalletAPI_resetWalletPin() async throws {
        let fncyWallet = FncyWalletCore(authToken: authToken)
        
        let pinString = "666666"
        let newPinString = "111111"
        
        do {
            let result = try await fncyWallet.resetWalletPin(oldPinNumber: pinString,
                                                             newPinNumber: newPinString)
            
            print("Success")
            print(String(describing: result))
            
        } catch(let error) {
            print("testWalletAPI Error cases")
            print(String(describing: error))
        }
        //        {
        //          "resultType" : "WalletPinChangeResultCodes",
        //          "result" : {
        //            "isSuccess" : true,
        //            "code" : "SUCCESS",
        //            "message" : "Success",
        //            "number" : 200
        //          }
        //        }
    }
    // 지갑 복원 - 사용자 선택 질문
    func testWalletAPI_getResetQuestion() async throws {
        let fncyWallet = FncyWalletCore(authToken: authToken)
        do {
            let result = try await fncyWallet.getResetQuestion()
            print(String(describing: result))
            XCTAssert(true, String(describing: result))
        } catch(let error) {
            XCTAssert(false, String(describing: error))
        }
    }
    // 지갑 복원 - 사용자 선택 질문(토큰없을때 실패케이스)
    func testWalletAPI_getResetQuestion_withoutAuthToken() async throws {
        let fncyWallet = FncyWalletCore(authToken: "")
        do {
            let result = try await fncyWallet.getResetQuestion()
            print(String(describing: result))
//            XCTAssertEqual(result.result?.number,
//                           401,
//                           "catch authentication failed")
        } catch(let error) {
            XCTAssert(false, String(describing: error))
        }
    }
    // 지갑 복원 - 질문 답변
    func testWalletAPI_postResetQuestion() async throws {
        let fncyWallet = FncyWalletCore(authToken: authToken)
        
        let newPinString = "111111"
        let answer = "모모"
        
        do {
            let result = try await fncyWallet.postResetQuestion(answer: answer,
                                                                newPinNumber: newPinString)
            
            print("Success")
            print(String(describing: result))
            
        } catch(let error) {
            print("testWalletAPI Error cases")
            print(String(describing: error))
        }
        
//        {
//          "resultType" : "WalletPinChangeResultCodes",
//          "result" : {
//            "number" : 200,
//            "isSuccess" : true,
//            "message" : "Success",
//            "code" : "SUCCESS"
//          }
//        }
    }
    
    func testWalletAPI_postResetQuestion_failing() async throws {
        let fncyWallet = FncyWalletCore(authToken: authToken)
        
        let newPinString = "111111"
        let answer = "모모"
        
        do {
            let result = try await fncyWallet.postResetQuestion(answer: answer,
                                                                newPinNumber: newPinString)
            
            print("Success")
            print(String(describing: result))
            
        } catch(let error) {
            print("testWalletAPI Error cases")
            print(String(describing: error))
        }
        
//        {
//          "resultType" : "WalletPinChangeResultCodes",
//          "result" : {
//            "number" : 200,
//            "isSuccess" : true,
//            "message" : "Success",
//            "code" : "SUCCESS"
//          }
//        }
    }
    
    // MARK: - 지갑(지갑 조회)✅
    func testWalletAPI_getWallet() async throws {
        let fncyWallet = FncyWalletCore(authToken: authToken)
        
        do {
            let result = try await fncyWallet.getWallet()
            
            print("Success")
            print(String(describing: result))
            
        } catch(let error) {
            print("testWalletAPI Error cases")
            print(String(describing: error))
        }
    }
    
    func testWalletAPI_getWalletAllBalance() async throws {
        let walletID: Int = 10535
        
        let fncyWallet = FncyWalletCore(authToken: authToken)
        
        do {
            let result = try await fncyWallet.getWalletAllBalance(wid: walletID)
            
            print("Success")
            print(String(describing: result))
            
        } catch(let error) {
            print("testWalletAPI Error cases")
            print(String(describing: error))
        }
    }
    
    func testWalletAPI_getWalletAllBalance_failCases() async throws {
        let walletID: Int = -1 // <- not my wid
        
        let fncyWallet = FncyWalletCore(authToken: "")
        
        do {
            let result = try await fncyWallet.getWalletAllBalance(wid: walletID)
            
            print("Success")
            print(String(describing: result))
            
        } catch(let error) {
            print("testWalletAPI Error cases")
            print(String(describing: error))
        }
    }
    //
    
    func testWalletAPI_getAssetList() async throws {
        let walletID: Int = 10535
        
        let fncyWallet = FncyWalletCore(authToken: authToken)
        
        do {
            let result = try await fncyWallet.getAssetList(wid: walletID)
            
            print("Success")
            print(String(describing: result))
            
        } catch(let error) {
            print("testWalletAPI Error cases")
            print(String(describing: error))
        }
    }
    
    func testWalletAPI_getAssetById() async throws {
        let walletID: Int = 10535
        let assetIds : [Int] = [6, 2, 5, 4, 10001, 10006, 10270, 10271, 10272, 10276]
        
        let fncyWallet = FncyWalletCore(authToken: authToken)
        
        do {
            for assetId in assetIds {
                let result = try await fncyWallet.getAssetById(wid: walletID, assetId: assetId)
                
                print(String(describing: result))
            }
            
            print("Success")
            
        } catch(let error) {
            print("testWalletAPI Error cases")
            print(String(describing: error))
        }
    }
    
    func testWalletAPI_getNFTList() async throws {
        let walletID: Int = 10535
        let fncyWallet = FncyWalletCore(authToken: authToken)
        do {
            let result = try await fncyWallet.getNFTList(wid: walletID)
            
            print("Success")
            print(String(describing: result))
            
        } catch(let error) {
            print("testWalletAPI Error cases")
            print(String(describing: error))
        }
    }
    
    func testWalletAPI_getNFTById() async throws {
        let walletId = 10535
        let nftId = 11028
        
        let fncyWallet = FncyWalletCore(authToken: authToken)
        do {
            let result = try await fncyWallet.getNFTById(wid : walletId, nftId: nftId)
            
            print("Success")
            print(String(describing: result))
            
        } catch(let error) {
            print("testWalletAPI Error cases")
            print(String(describing: error))
        }
    }
}

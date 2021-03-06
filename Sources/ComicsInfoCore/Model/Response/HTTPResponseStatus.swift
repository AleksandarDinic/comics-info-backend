//
//  HTTPResponseStatus.swift
//  ComicsInfoCore
//
//  Created by Aleksandar Dinic on 09/09/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

public struct HTTPResponseStatus: Codable {

    public let code: UInt

    public static var `continue`: HTTPResponseStatus { HTTPResponseStatus(code: 100) }
    public static var switchingProtocols: HTTPResponseStatus { HTTPResponseStatus(code: 101) }
    public static var processing: HTTPResponseStatus { HTTPResponseStatus(code: 102) }
    public static var earlyHints: HTTPResponseStatus { HTTPResponseStatus(code: 103) }

    public static var ok: HTTPResponseStatus { HTTPResponseStatus(code: 200) }
    public static var created: HTTPResponseStatus { HTTPResponseStatus(code: 201) }
    public static var accepted: HTTPResponseStatus { HTTPResponseStatus(code: 202) }
    public static var nonAuthoritativeInformation: HTTPResponseStatus { HTTPResponseStatus(code: 203) }
    public static var noContent: HTTPResponseStatus { HTTPResponseStatus(code: 204) }
    public static var resetContent: HTTPResponseStatus { HTTPResponseStatus(code: 205) }
    public static var partialContent: HTTPResponseStatus { HTTPResponseStatus(code: 206) }
    public static var multiStatus: HTTPResponseStatus { HTTPResponseStatus(code: 207) }
    public static var alreadyReported: HTTPResponseStatus { HTTPResponseStatus(code: 208) }
    public static var imUsed: HTTPResponseStatus { HTTPResponseStatus(code: 226) }

    public static var multipleChoices: HTTPResponseStatus { HTTPResponseStatus(code: 300) }
    public static var movedPermanently: HTTPResponseStatus { HTTPResponseStatus(code: 301) }
    public static var found: HTTPResponseStatus { HTTPResponseStatus(code: 302) }
    public static var seeOther: HTTPResponseStatus { HTTPResponseStatus(code: 303) }
    public static var notModified: HTTPResponseStatus { HTTPResponseStatus(code: 304) }
    public static var useProxy: HTTPResponseStatus { HTTPResponseStatus(code: 305) }
    public static var temporaryRedirect: HTTPResponseStatus { HTTPResponseStatus(code: 307) }
    public static var permanentRedirect: HTTPResponseStatus { HTTPResponseStatus(code: 308) }

    public static var badRequest: HTTPResponseStatus { HTTPResponseStatus(code: 400) }
    public static var unauthorized: HTTPResponseStatus { HTTPResponseStatus(code: 401) }
    public static var paymentRequired: HTTPResponseStatus { HTTPResponseStatus(code: 402) }
    public static var forbidden: HTTPResponseStatus { HTTPResponseStatus(code: 403) }
    public static var notFound: HTTPResponseStatus { HTTPResponseStatus(code: 404) }
    public static var methodNotAllowed: HTTPResponseStatus { HTTPResponseStatus(code: 405) }
    public static var notAcceptable: HTTPResponseStatus { HTTPResponseStatus(code: 406) }
    public static var proxyAuthenticationRequired: HTTPResponseStatus { HTTPResponseStatus(code: 407) }
    public static var requestTimeout: HTTPResponseStatus { HTTPResponseStatus(code: 408) }
    public static var conflict: HTTPResponseStatus { HTTPResponseStatus(code: 409) }
    public static var gone: HTTPResponseStatus { HTTPResponseStatus(code: 410) }
    public static var lengthRequired: HTTPResponseStatus { HTTPResponseStatus(code: 411) }
    public static var preconditionFailed: HTTPResponseStatus { HTTPResponseStatus(code: 412) }
    public static var payloadTooLarge: HTTPResponseStatus { HTTPResponseStatus(code: 413) }
    public static var uriTooLong: HTTPResponseStatus { HTTPResponseStatus(code: 414) }
    public static var unsupportedMediaType: HTTPResponseStatus { HTTPResponseStatus(code: 415) }
    public static var rangeNotSatisfiable: HTTPResponseStatus { HTTPResponseStatus(code: 416) }
    public static var expectationFailed: HTTPResponseStatus { HTTPResponseStatus(code: 417) }
    public static var imATeapot: HTTPResponseStatus { HTTPResponseStatus(code: 418) }
    public static var misdirectedRequest: HTTPResponseStatus { HTTPResponseStatus(code: 421) }
    public static var unprocessableEntity: HTTPResponseStatus { HTTPResponseStatus(code: 422) }
    public static var locked: HTTPResponseStatus { HTTPResponseStatus(code: 423) }
    public static var failedDependency: HTTPResponseStatus { HTTPResponseStatus(code: 424) }
    public static var upgradeRequired: HTTPResponseStatus { HTTPResponseStatus(code: 426) }
    public static var preconditionRequired: HTTPResponseStatus { HTTPResponseStatus(code: 428) }
    public static var tooManyRequests: HTTPResponseStatus { HTTPResponseStatus(code: 429) }
    public static var requestHeaderFieldsTooLarge: HTTPResponseStatus { HTTPResponseStatus(code: 431) }
    public static var unavailableForLegalReasons: HTTPResponseStatus { HTTPResponseStatus(code: 451) }

    public static var internalServerError: HTTPResponseStatus { HTTPResponseStatus(code: 500) }
    public static var notImplemented: HTTPResponseStatus { HTTPResponseStatus(code: 501) }
    public static var badGateway: HTTPResponseStatus { HTTPResponseStatus(code: 502) }
    public static var serviceUnavailable: HTTPResponseStatus { HTTPResponseStatus(code: 503) }
    public static var gatewayTimeout: HTTPResponseStatus { HTTPResponseStatus(code: 504) }
    public static var httpVersionNotSupported: HTTPResponseStatus { HTTPResponseStatus(code: 505) }
    public static var variantAlsoNegotiates: HTTPResponseStatus { HTTPResponseStatus(code: 506) }
    public static var insufficientStorage: HTTPResponseStatus { HTTPResponseStatus(code: 507) }
    public static var loopDetected: HTTPResponseStatus { HTTPResponseStatus(code: 508) }
    public static var notExtended: HTTPResponseStatus { HTTPResponseStatus(code: 510) }
    public static var networkAuthenticationRequired: HTTPResponseStatus { HTTPResponseStatus(code: 511) }

}

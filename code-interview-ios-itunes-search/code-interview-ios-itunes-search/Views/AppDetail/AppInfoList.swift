//
//  AppInfoList.swift
//  code-interview-ios-itunes-search
//
//  Created by Martin on 2023/08/31.
//

import SwiftUI


struct ExpandableListCell: View {
    @State private var isExpanded: Bool = false
    private let title: String
    private let content: String
    private let detail: String
    private let isExpandable: Bool
    
    init(
        title: String,
        content: String,
        detail: String = ""
    ) {
        self.title = title
        self.content = content
        self.detail = detail
        self.isExpandable = !detail.isEmpty
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .foregroundColor(.secondary)
                Spacer()
                Group {
                    Text(content)
                    if isExpandable {
                        Button {
                            isExpanded.toggle()
                        } label: {
                            Image(systemName: "chevron.down")
                        }
                        .foregroundColor(.secondary)
                    }
                }
                .opacity(isExpanded ? 0 : 1)
            }
            
            if isExpanded {
                Text(detail)
                    .multilineTextAlignment(.leading)
            }
            
            Divider()
        }
        .font(.system(size: 14))
    }
}


struct AppInfoList: View {
    private let sellerName: String
    private let fileSizeBytes: String
    private let primaryGenre: String
    private let languages: [String]
    
    init(
        sellerName: String,
        fileSizeBytes: String,
        primaryGenreName: String,
        languages: [String]
    ) {
        self.sellerName = sellerName
        self.fileSizeBytes = fileSizeBytes
        self.primaryGenre = primaryGenreName
        self.languages = languages
    }
    
    private var fileSizeDescription: String {
        let formatter = ByteCountFormatter()
        let fileSyze: Int64 = Int64(fileSizeBytes) ?? 0
        return formatter.string(fromByteCount: fileSyze)
    }
    
    private var languagesDescription: String {
        let mainLanguage: String? = languages.contains("KO") ? "KO".languageNameFromISOCode() : languages.first?.languageNameFromISOCode()
        let subLanguagesCount = languages.count == 1 ? 0 : languages.count - 1
        let description = subLanguagesCount == 0 ? "" : " 외 \(subLanguagesCount)개"
        return "\(mainLanguage ?? "한국어")\(description)"
    }
    
    private var allLanguageString: String {
        guard languages.count > 1 else { return "" }
        return languages
            .map { $0.languageNameFromISOCode() ?? "" }
            .joined(separator: ", ")
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: .spacing(multiplier: 2)) {
            Text("정보")
                .font(.title3.bold())
            
            ExpandableListCell(
                title: "제공자",
                content: sellerName
            )
            
            ExpandableListCell(
                title: "크기",
                content: fileSizeDescription
            )
            
            ExpandableListCell(
                title: "카테고리",
                content: primaryGenre
            )
            
            ExpandableListCell(
                title: "언어",
                content: languagesDescription,
                detail: allLanguageString
            )
        }
        .listStyle(.plain)
    }
}

struct AppInfoList_Previews: PreviewProvider {
    static var previews: some View {
        let sample = Application.sample
        AppInfoList(
            sellerName: sample.sellerName,
            fileSizeBytes: sample.fileSizeBytes,
            primaryGenreName: sample.primaryGenreName,
            languages: sample.languages
        )
    }
}

//
//  ImageView.swift
//  interaction-board-webapp
//
//  Created by Lorenz Hänggi on 06.09.20.
//  Copyright © 2020 Lorenz Hänggi. All rights reserved.
//

import Foundation
import SwiftUI

struct ImageView: View {
    @ObservedObject var imageLoader:ImageLoader
    @State var image:UIImage = UIImage()

    init(url:URL, width:CGFloat = 50, height:CGFloat = 50) {
        self.imageLoader = ImageLoader(url:url)
        self.width = width
        self.height = height
    }
    init(urlString:String, width:CGFloat = 50, height:CGFloat = 50) {
        self.imageLoader = ImageLoader(urlString:urlString)
        self.width = width
        self.height = height
    }
    var width, height: CGFloat

    var body: some View {

        Image(uiImage: self.image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.black, lineWidth: 2))
            .frame(width:self.width, height:self.width)
            .onReceive(self.imageLoader.didChange) { image in
                self.image = image
            }
            .onAppear {
                self.image = self.imageLoader.image
            }
    }
}

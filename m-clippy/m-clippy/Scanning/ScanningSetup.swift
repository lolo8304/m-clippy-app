//
//  ScanningSetup.swift
//  m-clippy
//
//  Created by Lorenz Hänggi on 28.09.20.
//

import SwiftUI
import AVFoundation

struct ScanningSetup: View {
    @EnvironmentObject var api:ClippyAPI
    var player: AVAudioPlayer?
    let audioScanUrl: URL
    
    @State private var barcodeIndex:Int = -1
    @State private var audioMuted = false;
    
    var barcodeUrl:URL {
        return URL(string: "https://barcode.tec-it.com/barcode.ashx?data=\(self.barcode)&code=EAN13")!
    }
    var product:ProductViolation {
        if (barcodeIndex  >= 0) {
            return self.api.reportings.list[barcodeIndex]
        } else {
            return ProductViolation.EmptyProduct()
        }
    }
    var barcode:String {
        return self.product.ArticleID
    }

    @State private var showBarcode:Bool = true
    
    init() {
        audioScanUrl = Bundle.main.url(forResource: "beep", withExtension: "wav")!
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            self.player = try AVAudioPlayer(contentsOf: audioScanUrl, fileTypeHint: AVFileType.wav.rawValue)
            self.player!.enableRate = false
            self.player!.prepareToPlay()
            self.player!.rate = 2.5
        } catch let error {
            print(error.localizedDescription)
        }
    }

    
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 0, content: {
                Image("scanner")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .padding(20)
                Button("Scan", action: {
                    if (!self.audioMuted) {
                        self.makeScanSound()
                    }
                    if (self.api.reportings.list.count > 0) {
                        self.barcodeIndex = Int.random(in: 0..<self.api.reportings.list.count)
                    } else {
                        self.barcodeIndex = -1
                    }
                    self.showBarcode = true
                })
                .padding(0)
                .foregroundColor(.black)
                .font(.title)
                .position(x: UIScreen.screenWidth / 2, y: -95)
                .zIndex(2)
                
                HStack {
                    Spacer()
                    Image(systemName: self.audioMuted ? "speaker.wave.2" : "speaker.slash")
                        .resizable()
                        .frame(width: 30, height: 30, alignment: .topLeading)
                        .aspectRatio(contentMode: .fit)
                        .disabled(self.audioMuted)
                        .onTapGesture(count: 1, perform: {
                            self.audioMuted = !self.audioMuted
                        })
                }.padding(20)
                .position(x: UIScreen.screenWidth / 2, y: -70)
                    
            })
            .aspectRatio(contentMode: .fill)
            .padding(0)
            
            VStack(alignment: .center, spacing: 0, content: {
                VStack (alignment: .leading, spacing: 0, content: {
                    ImageView(url: self.barcodeUrl, width: UIScreen.screenWidth * 0.4, height: 50)
                        .disabled(!self.showBarcode)
                })
                .zIndex(1.0)
                .frame(width: 0, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .padding(0)
                
                VStack {
                    HStack (alignment: .top, spacing: 0, content: {
                        ImageView(url: URL(string: self.product.Original)!, width: UIScreen.screenWidth * 0.25, height: 0).padding(0)
                        Spacer(minLength: 1)
                        VStack(alignment: .trailing, spacing: 0, content: {
                            Text("\(self.product.Name)").font(.headline).padding(0).lineLimit(3).fixedSize(horizontal: false, vertical: true)
                            Text("\(self.product.Quantity)").font(.subheadline)
                            Text("\(self.product.Price == 0.0 ? "" : self.product.Price.format(f:".2")) CHF").font(.subheadline)
                        })
                        .padding(.trailing, 5)
                    })
                    .padding(.top, 10)
                    HStack {
                        if (self.product.HabitsAlert) {
                            Image("habits-NOK")
                                .resizable()
                                .frame(width: 40, height: 40)
                        }
                        if (self.product.LocationAlert) {
                            Image("location-NOK")
                                .resizable()
                                .frame(width: 40, height: 40)
                        }
                        if (self.product.AllergyAlert) {
                            Image("allergy-NOK")
                                .resizable()
                                .frame(width: 40, height: 40)
                        }
                    }.font(.largeTitle)
                }.zIndex(2.0)
                .padding(0)

                Spacer()
            })
            .padding(5)
            .frame(width: UIScreen.screenWidth * 2.5 / 4, height: UIScreen.screenHeight / 2 + 50, alignment: .top)
        }.padding(0)
    }
    func makeScanSound() {
        /* iOS 10 and earlier require the following line:
        player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
        DispatchQueue.main.async {
            player!.play()
        }
    }
    
}

struct ScanningSetup_Previews: PreviewProvider {
    static var previews: some View {
        let api = ClippyAPI.Instance
        ScanningSetup().environmentObject(api)
    }
}

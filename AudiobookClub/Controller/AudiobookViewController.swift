//
//  AudiobookViewController.swift
//  AudiobookClub
//
//  Created by Courtney Pattison on 2017-05-02.
//  Copyright © 2017 Courtney Pattison. All rights reserved.
//

import AVFoundation
import AVKit
import UIKit

import Cosmos
import Kingfisher

class AudiobookViewController: UIViewController {
    
    // MARK: Properties

    @IBOutlet weak var audiobookTitleLabel: UILabel!
    @IBOutlet weak var audiobookAuthorsLabel: UILabel!
    @IBOutlet weak var audiobookDescriptionLabel: UILabel!
    @IBOutlet weak var audiobookSubjectsLabel: UILabel!
    @IBOutlet weak var audiobookRuntimeLabel: UILabel!
    @IBOutlet weak var audiobookStarRating: CosmosView!
    @IBOutlet weak var audiobookImage: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    
    var audiobook: Audiobook?
    
    // MARK: Methods
    
    func configureView() {
        if let audiobook = audiobook {
            if let title = audiobook.title {
                navigationItem.title = title
                audiobookTitleLabel.text = title
            }
            
            if let imageURL = audiobook.imageURL {
                var imageStr = String(describing: imageURL)
                imageStr = imageStr.replacingOccurrences(of: "_thumb", with: "")
                if let fullImageURL = URL(string: imageStr) {
                    let processor = RoundCornerImageProcessor(cornerRadius: 5)
                    audiobookImage.kf.setImage(with: fullImageURL, options: [.processor(processor)])
                } else {
                    audiobookImage.image = UIImage(named: "coverPlaceholder")
                }
            }
            
            let blue = UIColor(red: 0, green: 122 / 255.0, blue: 1, alpha: 1.0)
            playButton.setBackgroundColor(color: blue, forState: .highlighted)
            downloadButton.setBackgroundColor(color: blue, forState: .highlighted)
            
            if let authors = audiobook.authors?.joined(separator: ", ") {
                audiobookAuthorsLabel.text = authors
            }
            
            if let runtime = audiobook.runtime {
                audiobookRuntimeLabel.text = runtime.description()
            }
            
            if let rating = audiobook.rating {
                audiobookStarRating.rating = rating
            }
            
            if let subjects = audiobook.subjects {
                audiobookSubjectsLabel.text = subjects
            }
            
            if let description = audiobook.description {
                audiobookDescriptionLabel.text = description
                audiobookDescriptionLabel.numberOfLines = 7
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }

    // Mark: Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "audiobookPlayback" {
            let audioPlayerViewController = segue.destination as! AVPlayerViewController
            if let audioURL = URL(string: "https://ia802702.us.archive.org/18/items/jane_eyre_ver03_0809_librivox/janeeyre_01_bronte.mp3") {
                audioPlayerViewController.player = AVPlayer(url: audioURL)
            }
        }
    }
    
    // Mark: Actions
    
    @IBAction func playAudiobook(_ sender: UIButton) {
    }
    
    @IBAction func downloadAudiobook(_ sender: UIButton) {
    }
    
    @IBAction func moreDescription(_ sender: UIButton) {
        audiobookDescriptionLabel.numberOfLines = 0
        moreButton.isHidden = true
    }
    
    
}


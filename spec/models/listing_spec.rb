require 'rails_helper'

describe Listing do
  context 'Returns the data to be listed' do
    it 'returns one listing' do

      response =
                      {
                        "kind": "t3",
                        :data => {
                          "subreddit": "funny",
                          "likes": "null",
                          "id": "5h29b2",
                          :author => "TEST_FOR_AUTHOR",
                          "name": "t3_5h29b2",
                          "score": 65385,
                          "preview": {
                            "images": [
                              {
                                "source": {
                                  "url": "https://i.redditmedia.com/JLLtk3zo_oOma6-znRDCmcRV0qjoSbn8N0WZSsWy8pE.jpg?s=e11a7297276adbd7488dcf26a4846180",
                                  "width": 720,
                                  "height": 960
                                },
                                "resolutions": [
                                  {
                                    "url": "https://i.redditmedia.com/JLLtk3zo_oOma6-znRDCmcRV0qjoSbn8N0WZSsWy8pE.jpg?fit=crop&amp;crop=faces%2Centropy&amp;arh=2&amp;w=108&amp;s=b7eed40f6cd1cce823e5ad354fdf6889",
                                    "width": 108,
                                    "height": 144
                                  },
                                  {
                                    "url": "https://i.redditmedia.com/JLLtk3zo_oOma6-znRDCmcRV0qjoSbn8N0WZSsWy8pE.jpg?fit=crop&amp;crop=faces%2Centropy&amp;arh=2&amp;w=216&amp;s=b98d3b57fcefefa89eb4f6eb439a098b",
                                    "width": 216,
                                    "height": 288
                                  }]
                              }
                            ]
                          },
                          :thumbnail => "http://b.thumbs.redditmedia.com/aR6qeqPqWoZz-TJh-eG1IANE7ivewgc1ctQKVz1Nt5w.jpg",
                          "subreddit_id": "t5_2qh33",
                          "url": "https://i.redd.it/tb5pckm6e72y.jpg",
                          :title => "Contractor gets in the cabinet he just built to prove its sturdiness"
                        }
                      }
                    

      one_listing = Listing.new(response)
      

      expect(one_listing.author).to eq("TEST_FOR_AUTHOR")
      expect(one_listing.thumbnail).to eq("http://b.thumbs.redditmedia.com/aR6qeqPqWoZz-TJh-eG1IANE7ivewgc1ctQKVz1Nt5w.jpg")
      expect(one_listing.title).to eq("Contractor gets in the cabinet he just built to prove its sturdiness")
    end

    it 'returns listing objects for repos' do
      VCR.use_cassette('listing_model') do
        token = ENV['reddit_token']
        repos = Listing.get_listings(token)
        repo = repos.first

        expect(repos).to be_an(Array)
        expect(repo).to be_a(Listing)
        expect(repo).to respond_to(:title)
        expect(repo).to respond_to(:thumbnail)
        expect(repo).to respond_to(:author)
      end
    end
  end
end
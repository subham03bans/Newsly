package info.androidhive.slidingmenu.model;

import java.util.ArrayList;

public class NewsObject {
    public String headline;
    public String thumbnailUrl;
    public String content;
    public String summary;
    public String category;
    public String publisherName;
    public String agencyName;
    public String publicationDateTime;
    public String place;
    public int fbLikes = 0;
    public int tweets = 0;
    public int googlePlusShares = 0;
    public int upvotes = 0;
    public int downvotes = 0;
    public ArrayList<String> tags;

    public NewsObject() {
    }

    public NewsObject(String headline, String thumbnailUrl, String category) {
        this.headline = headline;
        this.thumbnailUrl = thumbnailUrl;
        this.category = category;
    }

    public NewsObject(String headline, String thumbnailUrl, String category, String publicationDateTime, String publisherName, int upvotes, int downvotes,
                      ArrayList<String> tags) {
        this.headline = headline;
        this.thumbnailUrl = thumbnailUrl;
        this.category = category;
        this.publicationDateTime = publicationDateTime;
        this.publisherName = publisherName;
        this.upvotes = upvotes;
        this.downvotes = downvotes;
        this.tags = tags;
    }

    public String getCategory() {
        char firstLetter = category.charAt(0);
        if(firstLetter>='a' && firstLetter<='z') {
            category = (char)(firstLetter-32)+category.substring(1);
        }
        return category;
    }
}

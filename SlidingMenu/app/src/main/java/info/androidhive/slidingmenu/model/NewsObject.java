package info.androidhive.slidingmenu.model;

import android.os.Parcel;
import android.os.Parcelable;

import java.util.ArrayList;
import java.util.Date;

public class NewsObject implements Parcelable{
    public String headline;
    public String thumbnailUrl;
    public String content;
    public String summary;
    public String category;
    public String publisherName;
    public String agencyName;
    public Date publicationDateTime;
    public String place;
    public int fbLikes = 0;
    public int tweets = 0;
    public int googlePlusShares = 0;
    public int upvotes = 0;
    public int downvotes = 0;
    public ArrayList<String> tags;

    public NewsObject() {
    }

    public static final Parcelable.Creator<NewsObject> CREATOR =
            new Parcelable.Creator<NewsObject>() {

                @Override
                public NewsObject createFromParcel(Parcel source) {
                    return new NewsObject(source);
                }

                @Override
                public NewsObject[] newArray(int size) {
                    return new NewsObject[size];
                }
            };

    public NewsObject(Parcel read){
        headline = read.readString();
        thumbnailUrl = read.readString();
        category = read.readString();
        summary = read.readString();
    }

    public NewsObject(String headline, String thumbnailUrl, String category) {
        this.headline = headline;
        this.thumbnailUrl = thumbnailUrl;
        this.category = category;
    }

    public NewsObject(String headline, String thumbnailUrl, String category, Date publicationDateTime, String publisherName, int upvotes, int downvotes,
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

    @Override
    public int describeContents() {
        return 0;
    }

    @Override
    public void writeToParcel(Parcel dest, int flags) {
        dest.writeString(headline);
        dest.writeString(thumbnailUrl);
        dest.writeString(category);
        dest.writeString(summary);
    }
}

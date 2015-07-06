package info.androidhive.slidingmenu;

import android.os.Parcel;
import android.os.Parcelable;

import java.util.ArrayList;
import java.util.List;

import info.androidhive.slidingmenu.model.NewsObject;

/**
 * Created by shubhambansal on 06/07/15.
 */

public class CurrentFragmentParcel implements Parcelable {
    private List<NewsObject> newsObjectsList;
    private String url;
    private String fragmentCategory;

    public CurrentFragmentParcel(List<NewsObject> newsObjectsList, String url, String fragmentCategory) {
        this.newsObjectsList = newsObjectsList;
        this.url = url;
        this.fragmentCategory = fragmentCategory;
    }

    public static final Parcelable.Creator<CurrentFragmentParcel> CREATOR = new Parcelable.Creator<CurrentFragmentParcel>() {
        public CurrentFragmentParcel createFromParcel(Parcel in) {
            return new CurrentFragmentParcel(in);
        }

        public CurrentFragmentParcel[] newArray(int size) {
            return new CurrentFragmentParcel[size];
        }
    };

    // example constructor that takes a Parcel and gives you an object populated with it's values
    private CurrentFragmentParcel(Parcel in) {
        newsObjectsList = new ArrayList<NewsObject>();
        in.readTypedList(newsObjectsList, NewsObject.CREATOR);
        url = in.readString();
        fragmentCategory = in.readString();
    }
    
    public int describeContents() {
        return 0;
    }

    // write your object's data to the passed-in Parcel
    public void writeToParcel(Parcel out, int flags) {
        out.writeTypedList(newsObjectsList);
        out.writeString(fragmentCategory);
        out.writeString(url);
    }

    public NewsObject getNews(int i) {
        return  newsObjectsList.get(i);
    }

    public int getNewsCount() {
        return newsObjectsList.size();
    }
}

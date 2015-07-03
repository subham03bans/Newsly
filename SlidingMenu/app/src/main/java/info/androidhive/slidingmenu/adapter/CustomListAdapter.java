package info.androidhive.slidingmenu.adapter;

import android.content.Context;
import java.util.Date;

import android.text.format.DateUtils;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;
import android.app.Fragment;

import com.android.volley.toolbox.ImageLoader;
import com.android.volley.toolbox.NetworkImageView;

import java.util.List;

import info.androidhive.slidingmenu.R;
import info.androidhive.slidingmenu.app.AppController;
import info.androidhive.slidingmenu.model.NewsObject;

public class CustomListAdapter extends BaseAdapter {
	private Fragment fragment;
	private LayoutInflater inflater;
	private List<NewsObject> newsObjectItems;
	ImageLoader imageLoader = AppController.getInstance().getImageLoader();

	public CustomListAdapter(Fragment fragment, List<NewsObject> newsObjectItems) {
		this.fragment = fragment;
		this.newsObjectItems = newsObjectItems;
	}

	@Override
	public int getCount() {
		return newsObjectItems.size();
	}

	@Override
	public Object getItem(int location) {
		return newsObjectItems.get(location);
	}

	@Override
	public long getItemId(int position) {
		return position;
	}

	@Override
	public View getView(int position, View convertView, ViewGroup parent) {

		if (inflater == null)
			inflater = (LayoutInflater) fragment.getActivity()
					.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
		if (convertView == null)
			convertView = inflater.inflate(R.layout.list_row, null);

		if (imageLoader == null)
			imageLoader = AppController.getInstance().getImageLoader();
		NetworkImageView thumbNail = (NetworkImageView) convertView
				.findViewById(R.id.thumbnail);

		TextView headline = (TextView) convertView.findViewById(R.id.headline);
		TextView category = (TextView) convertView.findViewById(R.id.category);
		TextView pubTime = (TextView) convertView.findViewById(R.id.pub_time);
		TextView upVotes = (TextView) convertView.findViewById(R.id.upvotes);
		TextView downVotes = (TextView) convertView.findViewById(R.id.downvotes);

		// getting NewsObject data for the row
		NewsObject newsObject = newsObjectItems.get(position);

		// thumbnail image
		thumbNail.setImageUrl(newsObject.thumbnailUrl, imageLoader);

		// headline
		headline.setText(newsObject.headline);

		// category
		category.setTextColor(fragment.getResources().getColor(getCategoryColor(newsObject.category)));
		category.setText(newsObject.getCategory());


		//publishDate/Time
		pubTime.setText(timeAgo(newsObject.publicationDateTime));

		//upvotes
		upVotes.setText(""+newsObject.upvotes);

		//downvotes
		downVotes.setText(""+newsObject.downvotes);

		// genre
		/*String genreStr = "";
		for (String str : m.getGenre()) {
			genreStr += str + ", ";
		}
		genreStr = genreStr.length() > 0 ? genreStr.substring(0,
				genreStr.length() - 2) : genreStr;
		genre.setText(genreStr);

		// release year
		year.setText(String.valueOf(m.getYear()));*/

		return convertView;
	}

    private int getCategoryColor(String category) {
        if(category.equals("india")) {
            return R.color.india_cat_color;
        } else if(category.equals("world")){
            return R.color.world_cat_color;
        } else if(category.equals("sports")){
            return R.color.sports_cat_color;
        } else if(category.equals("entertainment")){
            return R.color.entertainment_cat_color;
        } else if(category.equals("business")){
            return R.color.business_cat_color;
        } else if(category.equals("technology")){
            return R.color.technology_cat_color;
        } else {
            return R.color.action_bar_color;
        }
    }

    //Wow an amazing thing....DateUtils!!!
	private String timeAgo(Date datetime) {
        return DateUtils.getRelativeTimeSpanString(datetime.getTime()).toString();
	}

}
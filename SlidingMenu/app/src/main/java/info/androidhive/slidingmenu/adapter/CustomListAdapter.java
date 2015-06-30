package info.androidhive.slidingmenu.adapter;

import android.content.Context;
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
import info.androidhive.slidingmenu.model.Movie;

public class CustomListAdapter extends BaseAdapter {
	private Fragment fragment;
	private LayoutInflater inflater;
	private List<Movie> movieItems;
	//ImageLoader imageLoader = AppController.getInstance().getImageLoader();

	public CustomListAdapter(Fragment fragment, List<Movie> movieItems) {
		this.fragment = fragment;
		this.movieItems = movieItems;
	}

	@Override
	public int getCount() {
		return movieItems.size();
	}

	@Override
	public Object getItem(int location) {
		return movieItems.get(location);
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

		/*if (imageLoader == null)
			imageLoader = AppController.getInstance().getImageLoader();*/
		NetworkImageView thumbNail = (NetworkImageView) convertView
				.findViewById(R.id.thumbnail);
		TextView title = (TextView) convertView.findViewById(R.id.title);
		TextView rating = (TextView) convertView.findViewById(R.id.rating);
		TextView genre = (TextView) convertView.findViewById(R.id.genre);
		TextView year = (TextView) convertView.findViewById(R.id.releaseYear);

		// getting movie data for the row
		Movie m = movieItems.get(position);

		// thumbnail image
		//thumbNail.setImageUrl(m.getThumbnailUrl(), imageLoader);
		
		// title
		title.setText(m.getTitle());
		
		// rating
		rating.setText("Rating: " + String.valueOf(m.getRating()));
		
		// genre
		String genreStr = "";
		for (String str : m.getGenre()) {
			genreStr += str + ", ";
		}
		genreStr = genreStr.length() > 0 ? genreStr.substring(0,
				genreStr.length() - 2) : genreStr;
		genre.setText(genreStr);
		
		// release year
		year.setText(String.valueOf(m.getYear()));

		return convertView;
	}

}
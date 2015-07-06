package info.androidhive.slidingmenu;

import android.app.Fragment;
import android.app.ProgressDialog;
import android.content.Intent;
import android.os.Bundle;
import android.os.Parcel;
import android.os.Parcelable;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ListView;

import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.Request.Method;
import com.android.volley.toolbox.JsonObjectRequest;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Locale;
import java.util.Date;
import java.text.DateFormat;

import info.androidhive.slidingmenu.adapter.CustomListAdapter;
import info.androidhive.slidingmenu.app.AppController;
import info.androidhive.slidingmenu.model.NewsObject;
import info.androidhive.slidingmenu.util.Constants;

public class NewsFragment extends Fragment {
    private List<NewsObject> newsObjectsList;
    private ListView listView;
    private CustomListAdapter adapter;
    private ProgressDialog pDialog;
    private boolean flag;
    private String url;
    private String fragmentCategory;

    public NewsFragment() {
        flag = false;
        newsObjectsList = new ArrayList<NewsObject>();
    }

    public void setDataSourceURL(String fragmentCategory) {
        this.fragmentCategory = fragmentCategory;

        if(fragmentCategory.equals("home"))
            url = Constants.API_URL+Constants.HOME_URL;
        else if(fragmentCategory.equals("india"))
            url = Constants.API_URL+Constants.INDIA_URL;
        else if(fragmentCategory.equals("world"))
            url = Constants.API_URL+Constants.WORLD_URL;
        else if(fragmentCategory.equals("sports"))
            url = Constants.API_URL+Constants.SPORTS_URL;
        else if(fragmentCategory.equals("entertainment"))
            url = Constants.API_URL+Constants.ENTERTAINMENT_URL;
        else if(fragmentCategory.equals("business"))
            url = Constants.API_URL+Constants.BUSINESS_URL;
        else if(fragmentCategory.equals("technology"))
            url = Constants.API_URL+Constants.TECHNOLOGY_URL;
    }


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
            Bundle savedInstanceState) {
 
        View rootView = inflater.inflate(R.layout.fragment_news, container, false);


        listView = (ListView) rootView.findViewById(R.id.list);
        adapter = new CustomListAdapter(this, newsObjectsList);
        listView.setAdapter(adapter);

        if(!flag) {
            newsObjectsList.clear();
            fetchData();
            flag = true;
        }

        //setting item click listener
        listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long l) {
                CurrentFragmentParcel parcel = new CurrentFragmentParcel(newsObjectsList, url, fragmentCategory);
                Intent intent = new Intent(getActivity(), SummaryActivity.class);
                intent.putExtra("id", "" + i);
                intent.putExtra("type", "" + 1);
                intent.putExtra("current_fragment", parcel);

                getActivity().startActivity(intent);
            }
        });

        return rootView;
    }

    private void fetchData() {
        showPDialog();

        JsonObjectRequest newsReq = new JsonObjectRequest(Method.GET, url,
                null, new Response.Listener<JSONObject>() {
            @Override
            public void onResponse(JSONObject response) {
                hidePDialog();

                try {

                    // Getting JSON Array
                    JSONArray newsObjects = response.getJSONArray(Constants.TAG_NEWS);
                    int length = newsObjects.length();
                    String tempDateTime = "";

                    for (int i = 0; i < length; i++) {
                        JSONObject obj = newsObjects.getJSONObject(i);
                        NewsObject newsObject = new NewsObject();

                        newsObject.headline = obj.getString("headline");
                        newsObject.content = obj.getString("content");
                        newsObject.summary = obj.getString("summary");
                        newsObject.category = obj.getString("category");
                        newsObject.publisherName = obj.getString("publisher");
                        newsObject.agencyName = obj.getString("agency");
                        newsObject.thumbnailUrl = obj.getString("image_url");

                        //time and date
                        tempDateTime = obj.getString("pub_date");
                        DateFormat format = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss", Locale.ENGLISH);
                        Date date = null;
                        try {
                            date = format.parse(tempDateTime);
                        } catch (ParseException e) {
                            e.printStackTrace();
                        }
                        newsObject.publicationDateTime = date;

                        newsObject.place = obj.getString("place");

                        newsObject.fbLikes = obj.getInt("fb_likes");
                        newsObject.tweets = obj.getInt("tweets");
                        newsObject.googlePlusShares = obj.getInt("google_plus_shares");
                        newsObject.upvotes = obj.getInt("newsly_upvotes");
                        newsObject.downvotes = obj.getInt("newsly_downvotes");

                        // tags is a string
                        String tagsStr = obj.getString("tags");
                        String [] tagsArray = tagsStr.split(Constants.TAGS_DELIM);
                        newsObject.tags = new ArrayList<String>(Arrays.asList(tagsArray));

                        newsObjectsList.add(newsObject);

                    }

                } catch (JSONException e) {
                    e.printStackTrace();
                }

                Log.d("Inside fetch", "Hello " + newsObjectsList.size());

                // notifying list adapter about data changes
                // so that it renders the list view with updated data
                adapter.notifyDataSetChanged();

            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                hidePDialog();
            }
        });

        // Adding request to request queue
        AppController.getInstance().addToRequestQueue(newsReq);
    }

    private void showPDialog() {
        pDialog = new ProgressDialog(this.getActivity());
        pDialog.setMessage("Getting Data ...");
        pDialog.setIndeterminate(false);
        pDialog.setCancelable(true);
        pDialog.show();
    }

    private void hidePDialog() {
        if (pDialog != null) {
            pDialog.dismiss();
            pDialog = null;
        }
    }
}

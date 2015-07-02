package info.androidhive.slidingmenu;

import android.app.Fragment;
import android.app.ProgressDialog;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ListView;

import com.android.volley.Request.Method;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonObjectRequest;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import info.androidhive.slidingmenu.adapter.CustomListAdapter;
import info.androidhive.slidingmenu.app.AppController;
import info.androidhive.slidingmenu.model.NewsObject;
import info.androidhive.slidingmenu.util.Constants;

public class SearchFragment extends Fragment {
    private static List<NewsObject> newsObjectsList = new ArrayList<NewsObject>();
    private ListView listView;
    private CustomListAdapter adapter;
    private ProgressDialog pDialog;

    public SearchFragment(){}

	@Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
            Bundle savedInstanceState) {
 
        View rootView = inflater.inflate(R.layout.fragment_home, container, false);

        listView = (ListView) rootView.findViewById(R.id.list);
        adapter = new CustomListAdapter(this, newsObjectsList);
        listView.setAdapter(adapter);

        showPDialog();

        //new JSONParse().execute();
        String query_string;
        query_string = this.getArguments().getString("query_string");
        JSONObject postparams = new JSONObject();
        try {
            postparams.put("q",query_string);
        } catch (JSONException e) {
            e.printStackTrace();
        }

        JsonObjectRequest newsReq = new JsonObjectRequest(Method.POST, Constants.HOME_URL+"/search",
                postparams, new Response.Listener<JSONObject>() {

                    @Override
                    public void onResponse(JSONObject response) {
                        hidePDialog();

                        try {
                            // Getting JSON Array
                            Log.d("Length is:2 ","hi");
                            JSONArray newsObjects = response.getJSONArray(Constants.TAG_NEWS);
                            int length = newsObjects.length();
                            Log.d("Length is: ",""+length);
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
                                newsObject.publicationDateTime = obj.getString("pub_date");
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
        listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long l) {


                Intent intent= new Intent(getActivity(), MainActivity2Activity.class);

                Log.e("passed jsonn contro12l", "" + newsObjectsList.get(i).headline);

                intent.putExtra("id", ""+i);
                getActivity().startActivity(intent);
            }
        });
        return rootView;
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

    public static NewsObject get_news(int i) {

        return  newsObjectsList.get(i);
    }

    public static int get_news_numbers() {
        return newsObjectsList.size();
    }
}

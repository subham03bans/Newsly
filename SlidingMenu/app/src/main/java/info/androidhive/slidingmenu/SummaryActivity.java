package info.androidhive.slidingmenu;

import android.app.Activity;
import android.app.SearchManager;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.MotionEvent;
import android.view.View;
import android.webkit.WebView;
import android.widget.ScrollView;
import android.widget.SearchView;
import android.widget.TextView;

import com.android.volley.toolbox.NetworkImageView;

import info.androidhive.slidingmenu.app.AppController;
import info.androidhive.slidingmenu.model.NewsObject;


public class SummaryActivity extends Activity {
    private float x1,x2;
    static final int MIN_DISTANCE = 150;
    //left = 0 , right = 1
    static int SLIDE_DIR = 0;
    private int id = 1;
    private int type = 1;
    private CurrentFragmentParcel parcel;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Intent intent = getIntent();

        id = Integer.parseInt(intent.getStringExtra("id"));
        type = Integer.parseInt(intent.getStringExtra("type"));
        parcel = intent.getParcelableExtra("current_fragment");


        NewsObject newsToDisplay= new NewsObject();

        switch (type){
            case 1:
                newsToDisplay = parcel.getNews(id);
                break;
            case 2:
                newsToDisplay = SearchFragment.get_news(id);
                break;
        }

        setContentView(R.layout.activity_summary);

        TextView textView1 = (TextView) findViewById(R.id.headline_detailed_view);
        WebView webView = (WebView) findViewById(R.id.contents_detailed_view);
        TextView category = (TextView) findViewById(R.id.category_detailed_view);
        ScrollView scrollView = (ScrollView) findViewById(R.id.scrollview1);
        NetworkImageView imge1 = (NetworkImageView) findViewById(R.id.thumbnail_detailed_view);

        imge1.setImageUrl(newsToDisplay.thumbnailUrl, AppController.getInstance().getImageLoader());

        textView1.setText(newsToDisplay.headline);

        String summary = getString(R.string.summary_content_template_open)
                +newsToDisplay.summary
                +getString(R.string.summary_content_template_close);
        webView.loadData(summary, "text/html", "utf-8");

        category.setText(newsToDisplay.category);


        scrollView.setOnTouchListener(new View.OnTouchListener() {
            @Override
            public boolean onTouch(View view, MotionEvent event) {

                switch (event.getAction()) {
                    case MotionEvent.ACTION_DOWN:
                        x1 = event.getX();
                        break;
                    case MotionEvent.ACTION_UP:
                        x2 = event.getX();
                        float deltaX = x2 - x1;
                        if (Math.abs(deltaX) > MIN_DISTANCE) {
                            // Left to Right swipe action
                            if (x2 > x1) {
                                SLIDE_DIR = 1;
                                id = id -1;
                                if(id<0){
                                    id = 0;
                                } else
                                    reload();
                            }

                            // Right to left swipe action
                            else {
                                SLIDE_DIR = 0;
                                id = id + 1;
                                if(id >= parcel.getNewsCount()){
                                    id = 0;
                                } else
                                    reload();
                            }

                        }

                        break;
                }
                return false;
            }
        });




    }

    private void reload() {
        this.finish();

        Intent intent= new Intent(this, SummaryActivity.class);
        intent.putExtra("id", "" + id);
        intent.putExtra("type", "" + type);
        intent.putExtra("current_fragment", parcel);

        if (SLIDE_DIR==0) {
            overridePendingTransition(R.anim.pull_in_right, R.anim.push_out_left);
        } else{
            overridePendingTransition(R.anim.pull_in_left, R.anim.push_out_right);
        }

        this.startActivity(intent);
        return;
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.main, menu);
        // Associate searchable configuration with the SearchView
        SearchManager searchManager =
                (SearchManager) getSystemService(Context.SEARCH_SERVICE);
        SearchView searchView =
                (SearchView) menu.findItem(R.id.action_search).getActionView();
        searchView.setSearchableInfo(
                searchManager.getSearchableInfo(getComponentName()));


        return true;

    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }
}


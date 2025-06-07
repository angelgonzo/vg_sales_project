# 🎮 Global Video Game Sales Analysis Project

This project explores global video game sales data using **SQL** and **Power BI**. It aims to extract insights on industry trends, platform and publisher performance, genre popularity, and sales patterns across regions and time.

---

## 🧠 Project Objectives

* Understand which platforms and publishers dominate in different regions
* Analyze genre trends globally and regionally
* Track how game sales and releases have changed over time
* Identify standout combinations of platform, genre, and publisher
* Practice SQL data exploration and visualization using Power BI

---

## 📂 Project Structure

```plaintext
📁 video-game-sales-analysis/
├── data/
│   └── vgsales.csv
├── sql/
│   └── vg_sales_analytics.sql
├── powerbi/
│   └── vgsales_report.pbix
├── images/
│   └── vgsales_report.pdf
└── README.md
```

---

## 📊 Dataset Overview

* **Source**: [Kaggle - Video Game Sales with Ratings](https://www.kaggle.com/datasets/gregorut/videogame-sales-with-ratings)
* **File**: `vgsales.csv`
* **Size**: \~16,000 rows

### 🔑 Key Columns

| Column        | Description                       |
| ------------- | --------------------------------- |
| Name          | Game title                        |
| Platform      | Console/platform released on      |
| Year          | Release year                      |
| Genre         | Game genre (Action, Sports, etc.) |
| Publisher     | Publishing company                |
| NA\_Sales     | Sales in North America (millions) |
| EU\_Sales     | Sales in Europe (millions)        |
| JP\_Sales     | Sales in Japan (millions)         |
| Other\_Sales  | Sales in other regions (millions) |
| Global\_Sales | Total global sales (millions)     |

---

## 🧶 SQL Analysis

We used SQL to explore the dataset and answer key business questions. Example queries include:

* **Top publishers** globally and by region
* **Most successful platforms** in each region
* **Genre performance** across NA, EU, JP, and globally
* **Year-over-year trends** in sales and releases
* **Top combinations** of platform + genre for high average sales
* **Sales before and after 2010**

### 💡 Example SQL Questions

* Which platform sold the most units in North America?
* How does genre popularity vary across regions?
* Which genres grew or declined significantly over time?
* Do certain publishers perform better on specific platforms?
* How do average sales differ before and after 2010?

---

## 📊 Power BI Dashboard

The dashboard was built in **Power BI** to visualize trends and enable interactive analysis.

### 💻 Pages and Features

* **Sales Overview**: Total and regional sales by platform and year
* **Top Games**: Matrix of top-selling games by region and publisher
* **Genre Analysis**: Sales and trends by genre over time
* **Publisher Performance**: Visual comparison by publisher/platform
* **Filters/Slicers**: By genre, platform, year, publisher

---

## 📌 Key Insights

* **PS2 and X360** dominated in North America; **Nintendo platforms** showed consistent global success
* **Nintendo, Electronic Arts**, and **Activision** top global publishers
* **Action** and **Sports** were consistently high-selling genres
* Game releases and global sales **peaked around 2008–2010**
* Sales differ significantly **before and after 2010**, with a decline in physical releases

---

## 🛠️ Tools & Skills Used

* **SQL** for data exploration and transformation
* **Power BI** for interactive dashboards and visuals
* **DAX** for calculated columns and measures
* **Data storytelling**, filtering, and slicing
* **Data cleaning** in Power BI for type conversion (e.g., year column)

---

## 🏁 Next Steps / Future Improvements

* Merge with additional datasets (e.g., user ratings or ESRB)
* Add forecasting or predictive models
* Explore mobile vs console vs PC sales breakdown
* Publish an interactive dashboard to Power BI service

---

## 📄 License & Attribution

* Dataset from [Kaggle - Video Game Sales](https://www.kaggle.com/datasets/gregorut/videogame-sales-with-ratings)

---

## 🤛 Author

**Angel Gonzalez**
Aspiring Data Analyst | SQL & Power BI Enthusiast
[GitHub](https://github.com/angelgonzo)

---

> 🎮 *Level up your data skills—one project at a time.*

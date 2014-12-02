
((digest . "5a6d5d3408eed1b9acdb2cfc06c05471") (undo-list nil (10669 . 10670) (10649 . 10650) (10629 . 10630) (10609 . 10610) (10589 . 10590) (10569 . 10570) (10549 . 10550) (10529 . 10530) (10509 . 10510) (10489 . 10490) (10469 . 10470) (10450 . 10451) (10431 . 10432) (10412 . 10413) (10393 . 10394) (10374 . 10375) (10355 . 10356) (10336 . 10337) (10317 . 10318) (10298 . 10299) (apply 0 10298 10650 cua--rect-undo-handler [10298 10664 4 4 2 0 t nil] t 10298 10650) nil ("n" . 10649) ((marker) . -1) ((marker) . -1) ("n" . 10630) ((marker) . -1) ((marker) . -1) ("n" . 10611) ((marker) . -1) ((marker) . -1) ("n" . 10592) ((marker) . -1) ((marker) . -1) ("n" . 10573) ((marker) . -1) ((marker) . -1) ("n" . 10554) ((marker) . -1) ((marker) . -1) ("n" . 10535) ((marker) . -1) ((marker) . -1) ("n" . 10516) ((marker) . -1) ((marker) . -1) ("n" . 10497) ((marker) . -1) ((marker) . -1) ("n" . 10478) ((marker) . -1) ((marker) . -1) ("n" . 10459) ((marker) . -1) ((marker) . -1) ("n" . 10441) ((marker) . -1) ((marker) . -1) ("n" . 10423) ((marker) . -1) ((marker) . -1) ("n" . 10405) ((marker) . -1) ((marker) . -1) ("n" . 10387) ((marker) . -1) ((marker) . -1) ("n" . 10369) ((marker) . -1) ((marker) . -1) ("n" . 10351) ((marker) . -1) ((marker) . -1) ("n" . 10333) ((marker) . -1) ((marker) . -1) ("n" . 10315) ((marker) . -1) ((marker) . -1) ("n" . 10297) ((marker) . -1) ((marker) . -1) (t 21618 50220 0 0) (apply 0 10297 10668 cua--rect-undo-handler [10297 10684 3 3 2 0 t nil] t 10297 10668) nil ("
" . 10686) (t 21618 50102 0 0) nil (7897 . 12261) ("std::cout<<\"CS_INSERT_FULL_CS_SO_CAN_NOT \"<< cIn2-cIn1 << std::endl;
    }


  //pointer and insertion status
RDTSC(cIn3);
  std::pair<cs::Entry*, bool> entry = insertToSkipList(data, isUnsolicited);
RDTSC(cIn4);
std::cout<<\"CS_INSERT_POINTER_AND_INSERTION_STATUS \"<< cIn4-cIn3 << std::endl;

  //new entry
RDTSC(cIn5);
  if (static_cast<bool>(entry.first) && (entry.second == true))
    {
RDTSC(cIn6);
      m_cleanupIndex.push_back(entry.first);
RDTSC(cIn7);
std::cout<<\"CS_INSERT_NEW_ENTRY \"<< cIn6-cIn5 << std::endl;
std::cout<<\"CS_INSERT_CLEANUP_INDEX_ENTRY_FIRST \"<< cIn7-cIn6 << std::endl;
      return true;
    }
RDTSC(cIn8);
std::cout<<\"CS_INSERT_FALSE \"<< cIn8-cIn5 << std::endl;

  return false;
}

size_t
Cs::pickRandomLayer() const
{
  static boost::random::bernoulli_distribution<> dist(SKIPLIST_PROBABILITY);
  // TODO rewrite using geometry_distribution
  size_t layer;
  for (layer = 0; layer < SKIPLIST_MAX_LAYERS; ++layer) {
    if (!dist(getGlobalRng())) {
      break;
    }
  }
  return layer;
}

bool
Cs::isFull() const
{
  if (size() >= m_nMaxPackets) //size of the first layer vs. max size
    return true;

  return false;
}

bool
Cs::eraseFromSkipList(cs::Entry* entry)
{
  NFD_LOG_TRACE(\"eraseFromSkipList() \"  << entry->getFullName());
  NFD_LOG_TRACE(\"SkipList size \" << size());

  bool isErased = false;

  const std::map<int, std::list<cs::Entry*>::iterator>& iterators = entry->getIterators();

  if (!iterators.empty())
    {
      int layer = 0;

      for (SkipList::iterator it = m_skipList.begin(); it != m_skipList.end(); )
        {
          std::map<int, std::list<cs::Entry*>::iterator>::const_iterator i = iterators.find(layer);

          if (i != iterators.end())
            {
              (*it)->erase(i->second);
              entry->removeIterator(layer);
              isErased = true;

              //remove layers that do not contain any elements (starting from the second layer)
              if ((layer != 0) && (*it)->empty())
                {
                  delete *it;
                  it = m_skipList.erase(it);
                }
              else
                ++it;

              layer++;
            }
          else
            break;
      }
    }

  //delete entry;
  if (isErased)
  {
    entry->release();
    m_freeCsEntries.push(entry);
    m_nPackets--;
  }

  return isErased;
}

bool
Cs::evictItem()
{
  NFD_LOG_TRACE(\"evictItem()\");

  if (!m_cleanupIndex.get<unsolicited>().empty() &&
      (*m_cleanupIndex.get<unsolicited>().begin())->isUnsolicited())
  {
    NFD_LOG_TRACE(\"Evict from unsolicited queue\");

    eraseFromSkipList(*m_cleanupIndex.get<unsolicited>().begin());
    m_cleanupIndex.get<unsolicited>().erase(m_cleanupIndex.get<unsolicited>().begin());
    return true;
  }

  if (!m_cleanupIndex.get<byStaleness>().empty() &&
      (*m_cleanupIndex.get<byStaleness>().begin())->getStaleTime() < time::steady_clock::now())
  {
    NFD_LOG_TRACE(\"Evict from staleness queue\");

    eraseFromSkipList(*m_cleanupIndex.get<byStaleness>().begin());
    m_cleanupIndex.get<byStaleness>().erase(m_cleanupIndex.get<byStaleness>().begin());
    return true;
  }

  if (!m_cleanupIndex.get<byArrival>().empty())
  {
    NFD_LOG_TRACE(\"Evict from arrival queue\");

    eraseFromSkipList(*m_cleanupIndex.get<byArrival>().begin());
    m_cleanupIndex.get<byArrival>().erase(m_cleanupIndex.get<byArrival>().begin());" . 7897) ((marker . 10299) . -406) ((marker . 7897) . -1337) ((marker . 7897) . -293) (t 21618 48585 0 0) nil (" " . -15188) nil (" " . -15189) (t 21618 48270 0 0) nil (7602 . 14734) ("1 = 0;
  uint64_t c2 = 0;
  uint64_t c3 = 0;
  uint64_t c4 = 0;
  uint64_t c5 = 0;
  uint64_t c6 = 0;
  uint64_t c7 = 0;
  uint64_t c8 = 0;
  uint64_t c9 = 0;

  NFD_LOG_TRACE(\"insert() \" << data.getFullName());


  if (isFull())
    {
RDTSC(c1);
		evictItem();
RDTSC(c2);
std::cout<<\"CS_INSERT_FULL_CS_SO_CAN_NOT \"<< c2-c1 << std::endl;
    }


  //pointer and insertion status
RDTSC(c3);
  std::pair<cs::Entry*, bool> entry = insertToSkipList(data, isUnsolicited);
RDTSC(c4);
std::cout<<\"CS_INSERT_POINTER_AND_INSERTION_STATUS \"<< c4-c3 << std::endl;

  //new entry
RDTSC(c5);
  if (static_cast<bool>(entry.first) && (entry.second == true))
    {
RDTSC(c6);
      m_cleanupIndex.push_back(entry.first);
RDTSC(c7);
std::cout<<\"CS_INSERT_NEW_ENTRY \"<< c6-c5 << std::endl;
std::cout<<\"CS_INSERT_CLEANUP_INDEX_ENTRY_FIRST \"<< c7-c6 << std::endl;
      return true;
    }
RDTSC(c8);
std::cout<<\"CS_INSERT_FALSE \"<< c8-c5 << std::endl;

  return false;
}

size_t
Cs::pickRandomLayer() const
{
  static boost::random::bernoulli_distribution<> dist(SKIPLIST_PROBABILITY);
  // TODO rewrite using geometry_distribution
  size_t layer;
  for (layer = 0; layer < SKIPLIST_MAX_LAYERS; ++layer) {
    if (!dist(getGlobalRng())) {
      break;
    }
  }
  return layer;
}

bool
Cs::isFull() const
{
  if (size() >= m_nMaxPackets) //size of the first layer vs. max size
    return true;

  return false;
}

bool
Cs::eraseFromSkipList(cs::Entry* entry)
{
  NFD_LOG_TRACE(\"eraseFromSkipList() \"  << entry->getFullName());
  NFD_LOG_TRACE(\"SkipList size \" << size());

  bool isErased = false;

  const std::map<int, std::list<cs::Entry*>::iterator>& iterators = entry->getIterators();

  if (!iterators.empty())
    {
      int layer = 0;

      for (SkipList::iterator it = m_skipList.begin(); it != m_skipList.end(); )
        {
          std::map<int, std::list<cs::Entry*>::iterator>::const_iterator i = iterators.find(layer);

          if (i != iterators.end())
            {
              (*it)->erase(i->second);
              entry->removeIterator(layer);
              isErased = true;

              //remove layers that do not contain any elements (starting from the second layer)
              if ((layer != 0) && (*it)->empty())
                {
                  delete *it;
                  it = m_skipList.erase(it);
                }
              else
                ++it;

              layer++;
            }
          else
            break;
      }
    }

  //delete entry;
  if (isErased)
  {
    entry->release();
    m_freeCsEntries.push(entry);
    m_nPackets--;
  }

  return isErased;
}

bool
Cs::evictItem()
{
  NFD_LOG_TRACE(\"evictItem()\");

  if (!m_cleanupIndex.get<unsolicited>().empty() &&
      (*m_cleanupIndex.get<unsolicited>().begin())->isUnsolicited())
  {
    NFD_LOG_TRACE(\"Evict from unsolicited queue\");

    eraseFromSkipList(*m_cleanupIndex.get<unsolicited>().begin());
    m_cleanupIndex.get<unsolicited>().erase(m_cleanupIndex.get<unsolicited>().begin());
    return true;
  }

  if (!m_cleanupIndex.get<byStaleness>().empty() &&
      (*m_cleanupIndex.get<byStaleness>().begin())->getStaleTime() < time::steady_clock::now())
  {
    NFD_LOG_TRACE(\"Evict from staleness queue\");

    eraseFromSkipList(*m_cleanupIndex.get<byStaleness>().begin());
    m_cleanupIndex.get<byStaleness>().erase(m_cleanupIndex.get<byStaleness>().begin());
    return true;
  }

  if (!m_cleanupIndex.get<byArrival>().empty())
  {
    NFD_LOG_TRACE(\"Evict from arrival queue\");

    eraseFromSkipList(*m_cleanupIndex.get<byArrival>().begin());
    m_cleanupIndex.get<byArrival>().erase(m_cleanupIndex.get<byArrival>().begin());
    return true;
  }

  return false;
}

const Data*
Cs::find(const Interest& interest) const
{
  uint64_t c1  = 0;
  uint64_t c2  = 0;
  uint64_t c3  = 0;
  uint64_t c4  = 0;
  uint64_t c5  = 0;
  uint64_t c6  = 0;
  uint64_t c7  = 0;
  uint64_t c8  = 0;
  uint64_t c9  = 0;
  uint64_t c10 = 0;
  uint64_t c11 = 0;
  uint64_t c12 = 0;
  uint64_t c13 = 0;
  uint64_t c14 = 0;
  uint64_t c15 = 0;
  uint64_t c16 = 0;
  uint64_t c17 = 0;
  uint64_t c18 = 0;


RDTSC(c1);
  NFD_LOG_TRACE(\"find() \" << interest.getName());
RDTSC(c2);
std::cout<<\"CSLOOKUP_GET_INTEREST_NAME \"<< c2-c1 << std::endl;
  bool isIterated = false;

RDTSC(c3);
  SkipList::const_reverse_iterator topLayer = m_skipList.rbegin();
RDTSC(c4);
std::cout<<\"CSLOOKUP_SKIPLIST_BEGIN \"<< c4-c3 << std::endl;

RDTSC(c5);
  SkipListLayer::iterator head = (*topLayer)->begin();
RDTSC(c6);
std::cout<<\"CSLOOKUP_SKIPLIST_HEAD \"<< c6-c5 << std::endl;


uint64_t C1  = 0;
uint64_t C2  = 0;
uint64_t C3  = 0;
uint64_t C4  = 0;
uint64_t C5  = 0;
uint64_t C6  = 0;


  if (!(*topLayer)->empty())
    {
      //start from the upper layer towards bottom
      int layer = m_skipList.size() - 1;
      for (SkipList::const_reverse_iterator rit = topLayer; rit != m_skipList.rend(); ++rit)
        {
          //if we didn't do any iterations on the higher layers, start from the begin() again
          if (!isIterated){
RDTSC(c7);
            head = (*rit)->begin();
RDTSC(c8);
C1+=c8-c7;
//std::cout<<\"START_HEAD_BEGIN() \"<< C1 << std::endl;
		  }

//RDTSC(c9);
	if (head != (*rit)->end())
            {
              // it happens when begin() contains the element we want to find
//RDTSC(c9);
              if (!isIterated && (interest.getName().isPrefixOf((*head)->getFullName())))
                {
//RDTSC(c9);
                  if (layer > 0)
                    {
                      layer--;
                      continue; // try lower layer
                    }
                  else
                    {
                      isIterated = true;
                    }
//RDTSC(c10);
//C3+=c10-c9;
                }
              else
                {
                  SkipListLayer::iterator it = head;

                  while ((*it)->getFullName() < interest.getName())
                    {
//RDTSC(c13);
                     NFD_LOG_TRACE((*it)->getFullName() << \" < \" << interest.getName());
//RDTSC(c14);
//C4+=c14-c13;
//std::cout<<\"NFD_LOG_TRACE((*it)->GETFULLNAME()) \"<< C4 << std::endl;
                      head = it;
                      isIterated = true;

                      ++it;
                      if (it == (*rit)->end())
                        break;
                    }
                }
            }
//RDTSC(c10);
//C2+=c10-c9;
//std::cout<<\"NFD_LOG_TRACE((*it)->GETFULLNAME()) \"<< C4 << std::endl;
          if (layer > 0)
            {
//RDTSC(c15);
              head = (*head)->getIterators().find(layer - 1)->second; // move HEAD to the lower layer
//RDTSC(c16);
//C5+=c16-c15;
//std::cout<<\"MOVE_HEAD_TO_THE_LOWER_LAYER \"<< C5 << std::endl;
            }
          else //if we reached the first layer
            {
              if (isIterated){
//RDTSC(c17);
                return selectChild(interest, head);
//RDTSC(c18);
//C6+=c18-c17;
//std::cout<<\"IF_WE_REACHED_THE_FIRST_LAYER \"<< C6 << std::endl;

			  }
            }

          layer--;
        }
std::cout<<\"CSLOOKUP_START_HEAD_BEGIN() \"<< C1 << std::endl;
" . 7602) ((marker . 3213) . -4491) ((marker . 3869) . -4891) ((marker . 7602) . -273) ((marker) . -6637) ((marker) . -4660) ((marker . 7602) . -3758) ((marker . 7602) . -4341) ((marker . 10005) . -4491) ((marker . 3869) . -4891) (t 21618 47858 0 0) nil ("y" . -14476) nil (14476 . 14477) nil ("" . -14476) (14477 . 14477) nil ("" . -14211) (14212 . 14212) nil ("" . -14095) (14096 . 14096) nil ("" . -13622) (13623 . 13623) nil ("" . -13519) (13520 . 13520) nil ("" . -13306) (13307 . 13307) nil ("" . -13292) (13293 . 13293) nil ("" . -13066) (13067 . 13067) nil ("" . -13011) (13012 . 13012) nil ("" . -12890) (12891 . 12891) nil ("" . -12683) (12684 . 12684) nil ("" . -12672) (12673 . 12673) nil ("" . -12661) (12662 . 12662) nil ("" . -12625) (12626 . 12626) nil ("" . -12614) (12615 . 12615) nil ("" . -12153) (12154 . 12154) nil ("" . -12152) (12153 . 12153) nil ("" . -12092) (12093 . 12093) nil ("" . -11943) (11944 . 11944) nil ("" . -1904) (1905 . 1905) nil ("" . -1846) (1847 . 1847) nil ("" . -1753) (1754 . 1754) nil ("" . -12030) nil ("" . -12019) nil ("" . -11958) nil ("" . -11868) nil ("" . -11777) (t 21618 47829 0 0) nil ("" . 11703) ("" . 11683) ("" . 11663) ("" . 11643) ("" . 11623) ("" . 11603) ("" . 11583) ("" . 11563) ("" . 11543) ("" . 11523) ("" . 11503) ("" . 11483) ("" . 11463) ("" . 11443) ("" . 11423) ("" . 11403) ("" . 11383) ("" . 11363) (t 21618 47811 0 0) (apply 0 11363 11721 cua--rect-undo-handler [11363 11721 19 20 3 0 t nil] t 11363 11721) nil ("" . -12291) nil ("" . -12273) nil ("" . -12255) nil ("" . -12237) nil ("" . -12219) nil ("" . -12201) (t 21618 47196 0 0) nil ("" . 7763) nil (7744 . 7745) nil ("
" . 7744) nil ("" . 7744) nil ("" . 7725) nil ("" . 7706) nil ("" . 7687) nil ("" . 7668) nil ("" . 7649) nil ("" . 7630) nil ("" . 7611) (t 21618 47079 0 0)))

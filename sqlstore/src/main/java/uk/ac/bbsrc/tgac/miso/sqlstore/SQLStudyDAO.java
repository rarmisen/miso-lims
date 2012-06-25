/*
 * Copyright (c) 2012. The Genome Analysis Centre, Norwich, UK
 * MISO project contacts: Robert Davey, Mario Caccamo @ TGAC
 * *********************************************************************
 *
 * This file is part of MISO.
 *
 * MISO is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * MISO is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with MISO.  If not, see <http://www.gnu.org/licenses/>.
 *
 * *********************************************************************
 */

package uk.ac.bbsrc.tgac.miso.sqlstore;

import com.googlecode.ehcache.annotations.KeyGenerator;
import com.googlecode.ehcache.annotations.Property;
import net.sf.ehcache.Cache;
import net.sf.ehcache.CacheManager;
import net.sf.ehcache.Element;
import org.springframework.beans.factory.annotation.Autowired;
import uk.ac.bbsrc.tgac.miso.core.data.Project;
import com.eaglegenomics.simlims.core.SecurityProfile;
import uk.ac.bbsrc.tgac.miso.core.store.ExperimentStore;
import uk.ac.bbsrc.tgac.miso.core.store.ProjectStore;
import uk.ac.bbsrc.tgac.miso.core.store.Store;
import uk.ac.bbsrc.tgac.miso.core.store.StudyStore;
import com.googlecode.ehcache.annotations.Cacheable;
import com.googlecode.ehcache.annotations.TriggersRemove;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.simple.SimpleJdbcInsert;
import org.springframework.transaction.annotation.Transactional;
import uk.ac.bbsrc.tgac.miso.sqlstore.util.DbUtils;
import uk.ac.bbsrc.tgac.miso.core.data.AbstractStudy;
import uk.ac.bbsrc.tgac.miso.core.data.Experiment;
import uk.ac.bbsrc.tgac.miso.core.data.Study;
import uk.ac.bbsrc.tgac.miso.core.exception.MalformedExperimentException;
import uk.ac.bbsrc.tgac.miso.core.factory.DataObjectFactory;

import javax.persistence.CascadeType;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

/**
 * uk.ac.bbsrc.tgac.miso.sqlstore
 * <p/>
 * Info
 *
 * @author Rob Davey
 * @since 0.0.2
 */
public class SQLStudyDAO implements StudyStore {
  public static final String STUDIES_SELECT =
          "SELECT studyId, name, description, alias, accession, securityProfile_profileId, project_projectId, studyType " +
          "FROM Study";

  public static final String STUDY_SELECT_BY_ID =
          STUDIES_SELECT + " " + "WHERE studyId = ?";

  public static final String STUDIES_SELECT_BY_SEARCH =
          STUDIES_SELECT + " WHERE " +
          "name LIKE ? OR " +
          "alias LIKE ? OR " +
          "description LIKE ? ";

  public static final String STUDY_UPDATE =
          "UPDATE Study " +
          "SET name=:name, description=:description, alias=:alias, accession=:accession, securityProfile_profileId=:securityProfile_profileId, project_projectId=:project_projectId, studyType=:studyType " +
          "WHERE studyId=:studyId";

  public static final String STUDY_DELETE =
          "DELETE FROM Study WHERE studyId=:studyId";  

  public static final String STUDY_SELECT_BY_EXPERIMENT_ID =
          "SELECT s.studyId, s.name, s.description, s.alias, s.accession, s.securityProfile_profileId, s.project_projectId, s.studyType " +
          "FROM Study s, Experiment e " +
          "WHERE s.studyId=e.study_studyId " +
          "AND e.experimentId=?";

  public static final String STUDY_SELECT_BY_STUDY_TYPE =
          "SELECT s.studyId, s.name, s.description, s.alias, s.accession, s.securityProfile_profileId, s.project_projectId, s.studyType " +
          "FROM Study s, StudyType t " +
          "WHERE s.studyType=t.name " +
          "AND t.name=?";  

  public static final String STUDIES_BY_RELATED_PROJECT =
          "SELECT s.studyId, s.name, s.description, s.alias, s.accession, s.securityProfile_profileId, s.project_projectId, s.studyType " +
          "FROM Study s, Project_Study ps " +
          "WHERE s.studyId=ps.studies_studyId " +
          "AND ps.Project_projectId=?";

  public static final String STUDIES_BY_RELATED_SUBMISSION = 
          "SELECT s.studyId, s.name, s.description, s.alias, s.accession, s.securityProfile_profileId, s.project_projectId, s.studyType " +
          "FROM Study s, Submission_Study ss " +
          "WHERE s.studyId=ss.studies_studyId " +
          "AND ss.submission_submissionId=?";

  public static final String STUDY_TYPES_SELECT =
          "SELECT name " +
          "FROM StudyType";

  protected static final Logger log = LoggerFactory.getLogger(SQLStudyDAO.class);

  private JdbcTemplate template;
  private ProjectStore projectDAO;
  private ExperimentStore experimentDAO;
  private Store<SecurityProfile> securityProfileDAO;
  private CascadeType cascadeType;

  @Autowired
  private CacheManager cacheManager;

  public void setCacheManager(CacheManager cacheManager) {
    this.cacheManager = cacheManager;
  }

  @Autowired
  private DataObjectFactory dataObjectFactory;

  public void setDataObjectFactory(DataObjectFactory dataObjectFactory) {
    this.dataObjectFactory = dataObjectFactory;
  }  

  public void setProjectDAO(ProjectStore projectDAO) {
    this.projectDAO = projectDAO;
  }

  public void setExperimentDAO(ExperimentStore experimentDAO) {
    this.experimentDAO = experimentDAO;
  }

  public Store<SecurityProfile> getSecurityProfileDAO() {
    return securityProfileDAO;
  }

  public void setSecurityProfileDAO(Store<SecurityProfile> securityProfileDAO) {
    this.securityProfileDAO = securityProfileDAO;
  }

  public JdbcTemplate getJdbcTemplate() {
    return template;
  }

  public void setJdbcTemplate(JdbcTemplate template) {
    this.template = template;
  }

  public void setCascadeType(CascadeType cascadeType) {
    this.cascadeType = cascadeType;
  }

  private void purgeListCache(Study s, boolean replace) {
    Cache cache = cacheManager.getCache("studyListCache");
    if (cache.getKeys().size() > 0) {
      Object cachekey = cache.getKeys().get(0);
      List<Study> c = (List<Study>)cache.get(cachekey).getValue();
      if (c.remove(s)) {
        if (replace) {
          c.add(s);
        }
      }
      else {
        c.add(s);
      }
      cache.put(new Element(cachekey, c));
    }
  }

  private void purgeListCache(Study s) {
    purgeListCache(s, true);
  }

  @Transactional(readOnly = false, rollbackFor = IOException.class)
  @TriggersRemove(cacheName="studyCache",
                  keyGenerator = @KeyGenerator(
                          name = "HashCodeCacheKeyGenerator",
                          properties = {
                                  @Property(name = "includeMethod", value = "false"),
                                  @Property(name = "includeParameterTypes", value = "false")
                          }
                  )
  )
  public long save(Study study) throws IOException {
    Long securityProfileId = study.getSecurityProfile().getProfileId();
    if (this.cascadeType != null) {// && this.cascadeType.equals(CascadeType.PERSIST)) {
      securityProfileId = securityProfileDAO.save(study.getSecurityProfile());
    }

    MapSqlParameterSource params = new MapSqlParameterSource();
    params.addValue("alias", study.getAlias())
            .addValue("accession", study.getAccession())
            .addValue("description", study.getDescription())
            .addValue("securityProfile_profileId", securityProfileId)
            .addValue("project_projectId", study.getProject().getProjectId())
            .addValue("studyType", study.getStudyType());

    if (study.getStudyId() == AbstractStudy.UNSAVED_ID) {
      SimpleJdbcInsert insert = new SimpleJdbcInsert(template)
                            .withTableName("Study")
                            .usingGeneratedKeyColumns("studyId");
      String name = "STU"+ DbUtils.getAutoIncrement(template, "Study");
      params.addValue("name", name);
      Number newId = insert.executeAndReturnKey(params);
      study.setStudyId(newId.longValue());
      study.setName(name);

      Project p = study.getProject();

      SimpleJdbcInsert pInsert = new SimpleJdbcInsert(template)
                            .withTableName("Project_Study");

      MapSqlParameterSource poParams = new MapSqlParameterSource();
      poParams.addValue("Project_projectId", p.getProjectId())
              .addValue("studies_studyId", study.getStudyId());
      try {
        pInsert.execute(poParams);
      }
      catch(DuplicateKeyException dke) {
        //ignore
      }
    }
    else {
      params.addValue("studyId", study.getStudyId())
              .addValue("name", study.getName());
      NamedParameterJdbcTemplate namedTemplate = new NamedParameterJdbcTemplate(template);
      namedTemplate.update(STUDY_UPDATE, params);
    }

    if (this.cascadeType != null) {
      Project p = study.getProject();
      if (this.cascadeType.equals(CascadeType.PERSIST)) {
        if (p!=null) projectDAO.save(p);
      }
      else if (this.cascadeType.equals(CascadeType.REMOVE)) {
        if (p != null) {
          Cache pc = cacheManager.getCache("projectCache");
          pc.remove(DbUtils.hashCodeCacheKeyFor(p.getProjectId()));
        }

        purgeListCache(study);
      }
    }

    return study.getStudyId();
  }

  @Cacheable(cacheName="studyListCache",
      keyGenerator = @KeyGenerator(
              name = "HashCodeCacheKeyGenerator",
              properties = {
                      @Property(name="includeMethod", value="false"),
                      @Property(name="includeParameterTypes", value="false")
              }
      )
  )
  public List<Study> listAll() {
    return template.query(STUDIES_SELECT, new LazyStudyMapper());
  }

  public List<Study> listBySearch(String query) {
    String mySQLQuery = "%" + query + "%";
    return template.query(STUDIES_SELECT_BY_SEARCH, new Object[]{mySQLQuery,mySQLQuery,mySQLQuery}, new LazyStudyMapper());
  }

  @Transactional(readOnly = false, rollbackFor = IOException.class)
  @TriggersRemove(
          cacheName="studyCache",
          keyGenerator = @KeyGenerator (
              name = "HashCodeCacheKeyGenerator",
              properties = {
                      @Property(name="includeMethod", value="false"),
                      @Property(name="includeParameterTypes", value="false")
              }
          )
  )
  public boolean remove(Study study) throws IOException {
    NamedParameterJdbcTemplate namedTemplate = new NamedParameterJdbcTemplate(template);
    if (study.isDeletable() &&
           (namedTemplate.update(STUDY_DELETE,
                                 new MapSqlParameterSource().addValue("studyId", study.getStudyId())) == 1)) {
      Project p = study.getProject();
      if (this.cascadeType.equals(CascadeType.PERSIST)) {
        if (p!=null) projectDAO.save(p);
      }
      else if (this.cascadeType.equals(CascadeType.REMOVE)) {
        if (p != null) {
          Cache pc = cacheManager.getCache("projectCache");
          pc.remove(DbUtils.hashCodeCacheKeyFor(p.getProjectId()));
        }
        purgeListCache(study, false);
      }
      return true;
    }
    return false;
  }

  @Cacheable(cacheName="studyCache",
                  keyGenerator = @KeyGenerator(
                          name = "HashCodeCacheKeyGenerator",
                          properties = {
                                  @Property(name = "includeMethod", value = "false"),
                                  @Property(name = "includeParameterTypes", value = "false")
                          }
                  )
  )
  public Study get(long studyId) throws IOException {
    List eResults = template.query(STUDY_SELECT_BY_ID, new Object[]{studyId}, new StudyMapper());
    Study e = eResults.size() > 0 ? (Study) eResults.get(0) : null;
    return e;
  }

  public Study lazyGet(long studyId) throws IOException {
    List eResults = template.query(STUDY_SELECT_BY_ID, new Object[]{studyId}, new LazyStudyMapper());
    Study e = eResults.size() > 0 ? (Study) eResults.get(0) : null;
    return e;
  }

  public List<Study> listByProjectId(long projectId) throws IOException {
    return template.query(STUDIES_BY_RELATED_PROJECT, new Object[]{projectId}, new LazyStudyMapper());
  }

  public List<Study> listBySubmissionId(long submissionId) throws IOException {
    return template.query(STUDIES_BY_RELATED_SUBMISSION, new Object[]{submissionId}, new StudyMapper());
  }

  public Study getByExperimentId(long experimentId) throws IOException {
    List eResults = template.query(STUDY_SELECT_BY_EXPERIMENT_ID, new Object[]{experimentId}, new StudyMapper());
    Study e = eResults.size() > 0 ? (Study) eResults.get(0) : null;
    return e;
  }

  public List<Study> getByStudyType(long typeId) throws IOException {
    return template.query(STUDY_SELECT_BY_STUDY_TYPE, new Object[]{typeId}, new StudyMapper());
  }

  public List<String> listAllStudyTypes() throws IOException {
    return template.queryForList(STUDY_TYPES_SELECT, String.class);
  }

  public class LazyStudyMapper implements RowMapper<Study> {
    public Study mapRow(ResultSet rs, int rowNum) throws SQLException {
      Study s = dataObjectFactory.getStudy();
      s.setStudyId(rs.getLong("studyId"));
      s.setName(rs.getString("name"));
      s.setAlias(rs.getString("alias"));
      s.setAccession(rs.getString("accession"));
      s.setDescription(rs.getString("description"));
      s.setStudyType(rs.getString("studyType"));
      try {
        s.setSecurityProfile(securityProfileDAO.get(rs.getLong("securityProfile_profileId")));
        s.setProject(projectDAO.lazyGet(rs.getLong("project_projectId")));
      }
      catch (IOException e1) {
        e1.printStackTrace();
      }
      return s;
    }
  }

  public class StudyMapper implements RowMapper<Study> {
    public Study mapRow(ResultSet rs, int rowNum) throws SQLException {
      Study s = dataObjectFactory.getStudy();
      s.setStudyId(rs.getLong("studyId"));
      s.setName(rs.getString("name"));
      s.setAlias(rs.getString("alias"));
      s.setAccession(rs.getString("accession"));
      s.setDescription(rs.getString("description"));
      s.setStudyType(rs.getString("studyType"));
      try {
        s.setSecurityProfile(securityProfileDAO.get(rs.getLong("securityProfile_profileId")));
        s.setProject(projectDAO.get(rs.getLong("project_projectId")));

        for (Experiment e : experimentDAO.listByStudyId(rs.getLong("studyId"))) {
          s.addExperiment(e);
        }
      }
      catch (IOException e1) {
        e1.printStackTrace();
      }
      catch (MalformedExperimentException e) {
        e.printStackTrace();
      }
      return s;
    }
  }
}
